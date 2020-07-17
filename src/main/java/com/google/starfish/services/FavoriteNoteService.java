package com.google.starfish.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;  
import java.sql.ResultSet;  
import javax.sql.DataSource;
import java.util.List;
import java.util.ArrayList;
import java.util.Date;
import com.google.starfish.models.Note;

public class FavoriteNoteService {

  /** Gets a favorite note by the compoud id */
  public ResultSet getRowByCompoundId(DataSource pool, long noteId, String userId) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt = 
          "SELECT * "
        + "FROM favorite_notes "
        + "WHERE `note_id`= ? AND "
        + "`user_id` = ? "
        + "LIMIT 1;";
      try (PreparedStatement getStmt = conn.prepareStatement(stmt)) {
        getStmt.setLong(1, noteId);
        getStmt.setString(2, userId);
        ResultSet rs = getStmt.executeQuery();
        return rs;
      } 
    }
  }

  /** Deletes a favorite note by the compoud id */
  public ResultSet deleteRowByCompoundId(DataSource pool, long noteId, String userId) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt = 
          "DELETE * "
        + "FROM favorite_notes "
        + "WHERE `note_id`= ? AND "
        + "`user_id` = ? "
        + "LIMIT 1;";
      try (PreparedStatement getStmt = conn.prepareStatement(stmt)) {
        getStmt.setLong(1, noteId);
        getStmt.setString(2, userId);
        ResultSet rs = getStmt.executeQuery();
        return rs;
      } 
    }
  }

  /** Inserts a favorite note by noteId and userId */
  public void insertFavoriteNote(DataSource pool, long noteId, String userId) {
    if (userId == null) return;
    try (Connection conn = pool.getConnection()) {
      try {
        conn.setAutoCommit(false);
        String stmt =
            "INSERT INTO favorite_notes ( "
                + "note_id,"
                + "user_id ) "
          + "VALUES ( "
                + "?,"
                + "? ); ";
        try (PreparedStatement insertStmt = conn.prepareStatement(stmt)) {
          insertStmt.setLong(1, noteId);
          insertStmt.setString(2, userId);
          System.out.println(insertStmt);
          insertStmt.execute();
          conn.commit();
        }
      } catch(SQLException ex) {
        if (conn != null) {
          try {
            System.err.print("Transaction is being rolled back.");
            conn.rollback();
          } catch (SQLException excep) {
            System.err.print(excep);
          }
        }
      }
    } catch (SQLException ex) {
      System.err.print(ex);
    }
  }

  /** Gets an array of note objects that have been favorited by passed user id */
  public Note[] getFavoriteNotesByUserId(DataSource pool, String userId) throws SQLException {
    List<Note> notes = new ArrayList<>();
    try (Connection conn = pool.getConnection()) {
      String stmt = 
          "SELECT  a.* "
        + "FROM "
          + Table.NOTES.getSqlTable() + " AS a "
          + "INNER JOIN (SELECT * "
                      + "FROM " + Table.FAVORITE_NOTES.getSqlTable() + " "
                      + "WHERE user_id=?) "
          + "as b ON a.id=b.note_id;";
      try (PreparedStatement favNotesStmt = conn.prepareStatement(stmt)) {
        favNotesStmt.setString(1, userId);
        ResultSet rs = favNotesStmt.executeQuery();
        while (rs.next()) {
          long noteId = rs.getLong("id");
          String authorId = rs.getString("author_id");
          String school = rs.getString("school");
          String course = rs.getString("course");
          String title = rs.getString("title");
          String sourceUrl = rs.getString("title");
          String pdfSource = rs.getString("pdf_source");
          Date dateCreated = rs.getDate("date_created");
          long numDownloads = rs.getLong("num_downloads");
          long numFavorites = getNumFavoritesByNoteId(pool, noteId);

          Note thisNote = new Note.Builder()
                              .setId(noteId)
                              .setAuthorId(authorId)
                              .setRequiredLabels(school, course)
                              .setNoteTitle(title)
                              .setSourceUrl(sourceUrl)
                              .setOptionalPdfSource(pdfSource)
                              .setDateCreated(dateCreated)
                              .setNumDownloads(numDownloads)
                              .setNumFavorites(numFavorites)
                              .build();
          notes.add(thisNote);
        }
        rs.close();
        return notes.toArray(new Note[0]);
      }
    }
  }

  /** Gets the number of times a note has been favorited by note id */
  public long getNumFavoritesByNoteId(DataSource pool, long noteId) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt = 
          "SELECT COUNT(*) AS num_favorites "
        + "FROM " + Table.FAVORITE_NOTES.getSqlTable() + " "
        + "WHERE `note_id`=?;";
      try (PreparedStatement selectStmt = conn.prepareStatement(stmt)) {
        selectStmt.setLong(1, noteId);
        ResultSet rs = selectStmt.executeQuery();
        rs.next();
        long numFavorites = rs.getLong("num_favorites");
        rs.close();
        return numFavorites;
      }
    }
  }
}