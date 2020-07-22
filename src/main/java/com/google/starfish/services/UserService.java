package com.google.starfish.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;  
<<<<<<< HEAD
import java.sql.ResultSet;  
import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.Date;
import com.google.starfish.models.Note;

public class UserService extends GenericService {

  NoteService noteService = new NoteService();

  public ResultSet getById(DataSource pool, String id) throws SQLException {
    return super.getById(pool, id, Table.USERS);
  }

  public boolean deleteById(DataSource pool, String id) throws SQLException {
    return super.deleteById(pool, id, Table.USERS);
  }

  public Note[] getFavoriteNotesById(DataSource pool, String userId) throws SQLException {
    ArrayList<Note> notes = new ArrayList<>();
    try (Connection conn = pool.getConnection()) {
      String stmt = 
          "SELECT  a.* "
        + "FROM "
          + Table.NOTES + " AS a "
          + "INNER JOIN (SELECT * "
                      + "FROM " + Table.FAVORITE_NOTES + " "
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
          long numFavorites = noteService.getNumFavoritesById(pool, noteId);

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

  public Note[] getUploadedNotesById(DataSource pool, String userId) throws SQLException {
    ArrayList<Note> notes = new ArrayList<>();
    try (Connection conn = pool.getConnection()) {
      String stmt = 
          "SELECT * "
        + "FROM " + Table.NOTES + " "
        + "WHERE author_id=?;";
      try (PreparedStatement upldNotesStmt = conn.prepareStatement(stmt)) {
        upldNotesStmt.setString(1, userId);
        ResultSet rs = upldNotesStmt.executeQuery();
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
          long numFavorites = noteService.getNumFavoritesById(pool, noteId);

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
=======
import javax.sql.DataSource;

enum Event {
  FAVORITE, DOWNLOAD
}

/**
 * Service class for Users Table 
 */
public class UserService extends TableService {

  private String USERS = Table.USERS.getSqlTable();

  // Points modifiers for different events
  private final long FAVORITE_POINTS_MODIFIER = 3;
  private final long DOWNLOAD_POINTS_MODIFIER = 5;

  public UserService() {
    super(Table.USERS);
  }

  /** Increase user points when a user's note gets favorited */
  public boolean increasePointsOnFavorite(DataSource pool, String userId) {
    return increasePoints(pool, userId, Event.FAVORITE);
  }

  /** Increase user points when a user's note gets downloaded */
  public boolean increasePointsOnDownload(DataSource pool, String userId) {
    return increasePoints(pool, userId, Event.DOWNLOAD);
  }

  /** Variably increase user points based on event */
  private boolean increasePoints(DataSource pool, String userId, Event event) {
    if (userId == null) return false;
    try (Connection conn = pool.getConnection()) {
      try {
        conn.setAutoCommit(false);
        String stmt =
            "UPDATE " + USERS + " "
                + "SET points=points+? "
          + "WHERE id=?;";
        try (PreparedStatement updateStmt = conn.prepareStatement(stmt)) {
          long pointsModifier = getPointsModifier(event);
          updateStmt.setLong(1, pointsModifier);
          updateStmt.setString(2, userId);
          boolean updated = updateStmt.execute();
          conn.commit();
          return updated;
        }
      } catch(SQLException ex) {
        if (conn != null) {
          try {
            System.err.print("Transaction is being rolled back.");
            conn.rollback();
          } catch (SQLException excep) {
            System.err.print(excep);
            return false;
          }
        }
        return false;
      }
    } catch (SQLException ex) {
      System.err.print(ex);
      return false;
    }
  }

  /** Gets the points modifier based on the event */
  private long getPointsModifier(Event event) {
    long pointsModifier = 0;
    switch (event) {
      case FAVORITE:
        pointsModifier = FAVORITE_POINTS_MODIFIER;
        break;
      case DOWNLOAD:
        pointsModifier = DOWNLOAD_POINTS_MODIFIER;
        break;
      default:
        pointsModifier = FAVORITE_POINTS_MODIFIER;
    }
    return pointsModifier;
>>>>>>> master
  }
}
