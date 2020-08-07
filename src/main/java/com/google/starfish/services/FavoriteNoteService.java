package com.google.starfish.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;  
import java.sql.ResultSet;  
import java.sql.Date;
import javax.sql.DataSource;
import java.util.List;
import java.util.ArrayList;
import java.util.Calendar;
import com.google.starfish.models.Note;

/**
 * Service class for FavoriteNotes Table
 */
public class FavoriteNoteService {

  /** Enum to hold possible recency to get trending notes */
  public enum Recency {
    TODAY("today"),
    THIS_WEEK("this-week"),
    THIS_MONTH("this-month"),
    ALL_TIME("all-time");

    private String recency;

    Recency(String recency) {
      this.recency = recency;
    }

    public String getRecency() {
      return this.recency;
    }
  }

  private String FAVORITE_NOTES = Table.FAVORITE_NOTES.getSqlTable();
  private String NOTES = Table.NOTES.getSqlTable();
  private String NUM_FAVORITES_IN_TIMESPAN_ID = "count";
  private MiscNoteLabelService miscNoteLabelService = new MiscNoteLabelService(); 

  /** Deletes a favorite note by the compound id */
  public boolean deleteRowByCompoundId(DataSource pool, long noteId, String userId) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt = 
          "DELETE "
        + "FROM " + FAVORITE_NOTES + " "
        + "WHERE `note_id`= ? AND "
        + "`user_id` = ? "
        + "LIMIT 1;";
      try (PreparedStatement deleteStmt = conn.prepareStatement(stmt)) {
        deleteStmt.setLong(1, noteId);
        deleteStmt.setString(2, userId);
        boolean deleted = deleteStmt.execute();
        return deleted;
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
            "INSERT INTO " + FAVORITE_NOTES + " ( "
                + "note_id,"
                + "user_id,"
                + "date ) "
          + "VALUES ( "
                + "?,"
                + "?,"
                + "? ); ";
        try (PreparedStatement insertStmt = conn.prepareStatement(stmt)) {
          insertStmt.setLong(1, noteId);
          insertStmt.setString(2, userId);
          insertStmt.setDate(3, new Date(Calendar.getInstance().getTimeInMillis()));
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
        + NOTES + " AS a "
            + "INNER JOIN (SELECT * "
                        + "FROM " + FAVORITE_NOTES + " "
                        + "WHERE user_id=?) "
          + "as b ON a.id=b.note_id;";
      try (PreparedStatement favNotesStmt = conn.prepareStatement(stmt)) {
        favNotesStmt.setString(1, userId);
        ResultSet rs = favNotesStmt.executeQuery();
        while (rs.next()) {
          Note thisNote = constructNoteFromSqlResult(pool, rs);
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
      String sqlQueryId = "num_favorites";
      String stmt = 
          "SELECT COUNT(*) AS " + sqlQueryId + " "
        + "FROM " + FAVORITE_NOTES + " "
        + "WHERE `note_id`=?;";
      try (PreparedStatement selectStmt = conn.prepareStatement(stmt)) {
        selectStmt.setLong(1, noteId);
        ResultSet rs = selectStmt.executeQuery();
        rs.next();
        long numFavorites = rs.getLong(sqlQueryId);
        rs.close();
        return numFavorites;
      }
    }
  }

  /** Gets trending notes based on number of favorites in a given timespan, filtered by school and/or course */
  public Object[][] getTrendingNotesBySchoolOrCourse(DataSource pool, Recency recency, String school, String course) throws SQLException {
    String filterStmt = getStatementToFilterBySchoolOrCourse(school, course);
    Date date = getDateBasedOnRecency(recency);
    List<Object> notes = new ArrayList<>();
    try (Connection conn = pool.getConnection()) {
      String stmt = getTrendingNotesStatement(filterStmt);
      try (PreparedStatement selectStmt = conn.prepareStatement(stmt)) {
        selectStmt.setDate(1, date);
        ResultSet rs = selectStmt.executeQuery();
        while (rs.next()) {
          Note thisNote = constructNoteFromSqlResult(pool, rs);
          Long numFavoritesInTimespan = rs.getLong(NUM_FAVORITES_IN_TIMESPAN_ID);
          notes.add(new Object[] {thisNote, numFavoritesInTimespan});
        }
        rs.close();
        return notes.toArray(new Object[0][0]);
      }
    }
  }

  /** Gets a sql where clause that filters by school or course if school or course is not null */
  private String getStatementToFilterBySchoolOrCourse(String school, String course) {
    String filterStmt = "WHERE 1=1 ";
    if (school != null && !school.isEmpty()) {
      filterStmt += "AND `school`= '" + school + "' ";
    }
    if (course != null && !course.isEmpty()) {
      filterStmt += "AND `course`= '" + course + "' ";
    }
    return filterStmt;
  }

  /** Gets the sql query to return trending notes possibly filtered by school and/or course */
  private String getTrendingNotesStatement(String schoolAndCourseFilter) {
    String stmt = 
        "SELECT * "
      + "FROM " + NOTES + " AS a "
      + "LEFT JOIN (SELECT note_id, COUNT(*) AS " + NUM_FAVORITES_IN_TIMESPAN_ID + " "
                  + "FROM " + FAVORITE_NOTES + " "
                  + "WHERE date >= ? " 
                  + "GROUP BY note_id) AS b " 
      + "ON a.id=b.note_id ";
    if (schoolAndCourseFilter != null) stmt += schoolAndCourseFilter;
    stmt += "ORDER BY count DESC, id;";
    return stmt;
  }

  /** Gets the date based on recency */
  private Date getDateBasedOnRecency(Recency recency) {
    Date date;
    Calendar calendar = Calendar.getInstance();
    switch(recency) {
      case THIS_WEEK:
        calendar.add(Calendar.DAY_OF_MONTH, -7);
        break;
      case THIS_MONTH:
        calendar.add(Calendar.DAY_OF_MONTH, -30);
        break;
      case ALL_TIME:
        // No note should ever be favorited more than 100 years ago (for now...)
        calendar.add(Calendar.YEAR, -100);
        break;
      default:
    }
    date = new Date(calendar.getTimeInMillis());
    return date;
  }

  private Note constructNoteFromSqlResult(DataSource pool, ResultSet rs) throws SQLException {
    long noteId = rs.getLong("id");
    String authorId = rs.getString("author_id");
    String school = rs.getString("school");
    String course = rs.getString("course");
    String title = rs.getString("title");
    String sourceUrl = rs.getString("source_url");
    String pdfSource = rs.getString("pdf_source");
    Date dateCreated = rs.getDate("date_created");
    long numDownloads = rs.getLong("num_downloads");
    long numFavorites = getNumFavoritesByNoteId(pool, noteId);
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
}
