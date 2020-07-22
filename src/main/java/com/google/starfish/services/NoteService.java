package com.google.starfish.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;  
import java.sql.ResultSet;  
import javax.sql.DataSource;
import java.util.List;
import java.util.Date;
import java.util.ArrayList;
import com.google.starfish.models.Note;

/**
 * Service class for Notes Table
 */
public class NoteService extends TableService {

  private FavoriteNoteService favoriteNoteService = new FavoriteNoteService();
  private MiscNoteLabelService miscNoteLabelService  = new MiscNoteLabelService();
  private String NOTES = Table.NOTES.getSqlTable();

  public NoteService() {
    super(Table.NOTES);
  }

  public Note[] getUploadedNotesByUserId(DataSource pool, String userId) throws SQLException {
    List<Note> notes = new ArrayList<>();
    try (Connection conn = pool.getConnection()) {
      String stmt = 
          "SELECT * "
        + "FROM " + NOTES + " "
        + "WHERE author_id=?;";
      try (PreparedStatement upldNotesStmt = conn.prepareStatement(stmt)) {
        upldNotesStmt.setString(1, userId);
        ResultSet rs = upldNotesStmt.executeQuery();
        while (rs.next()) {
          notes.add(constructNoteFromSqlResult(pool, rs));
        }
        rs.close();
        return notes.toArray(new Note[0]);
      }
    }
  }

  private Note constructNoteFromSqlResult(DataSource pool, ResultSet rs) throws SQLException {
    long noteId = rs.getLong("id");
    String authorId = rs.getString("author_id");
    String school = rs.getString("school");
    String course = rs.getString("course");
    String title = rs.getString("title");
    String sourceUrl = rs.getString("title");
    String pdfSource = rs.getString("pdf_source");
    Date dateCreated = rs.getDate("date_created");
    long numDownloads = rs.getLong("num_downloads");
    long numFavorites = favoriteNoteService.getNumFavoritesByNoteId(pool, noteId);
    String[] miscLabels = miscNoteLabelService.getMiscLabelsByNoteId(pool, noteId);

    Note note = new Note.Builder()
                        .setId(noteId)
                        .setAuthorId(authorId)
                        .setRequiredLabels(school, course)
                        .setNoteTitle(title)
                        .setSourceUrl(sourceUrl)
                        .setOptionalPdfSource(pdfSource)
                        .setDateCreated(dateCreated)
                        .setNumDownloads(numDownloads)
                        .setNumFavorites(numFavorites)
                        .setMiscLabels(miscLabels)
                        .build();
    return note;
  }

  public void incrementDownloadsByNoteId(DataSource pool, long noteId) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt =
          "UPDATE " + NOTES + " "
        + "SET num_downloads=num_downloads+1 "
        + "WHERE id=?;";
      try (PreparedStatement updateNotesStmt = conn.prepareStatement(stmt)) {
        updateNotesStmt.setLong(1, noteId);
        updateNotesStmt.execute();
      }
    }
  }

  public Note getNoteByNoteId(DataSource pool, long noteId) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt =
          "SELECT * " 
        + "FROM " + NOTES + " "
        + "WHERE id=? " 
        + "LIMIT 1;";
      try(PreparedStatement getNotesStmt = conn.prepareStatement(stmt)) {
        getNotesStmt.setLong(1, noteId);
        ResultSet rs = getNotesStmt.executeQuery();
        rs.next();
        return constructNoteFromSqlResult(pool, rs);
      }
    }
  }
}
