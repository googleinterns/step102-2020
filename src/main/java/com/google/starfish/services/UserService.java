package com.google.starfish.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;  
import javax.sql.DataSource;
import java.sql.ResultSet;
import java.util.Date;
import com.google.starfish.models.User;
import com.google.starfish.models.Note;

enum Event {
  FAVORITE, DOWNLOAD
}

/**
 * Service class for Users Table 
 */
public class UserService extends TableService {

  private NoteService noteService = new NoteService();
  private FavoriteNoteService favoriteNoteService = new FavoriteNoteService();
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
  }

  public User getUserById(DataSource pool, String userId) throws SQLException {
     try (Connection conn = pool.getConnection()) {
      String stmt =
          "SELECT * "
        + "FROM users "
        + "WHERE id=? "
        + "LIMIT 1;";

      try (PreparedStatement userStmt = conn.prepareStatement(stmt)) {
        userStmt.setString(1, userId);
        ResultSet rs = userStmt.executeQuery();
        rs.next();
        return constructUserFromSqlResult(pool, rs);
      }
     }
  }

  private User constructUserFromSqlResult(DataSource pool, ResultSet rs) throws SQLException {
    String userId = rs.getString("id");
    String displayPicture = rs.getString("display_picture");
    String displayName = rs.getString("display_name");
    Date dateJoined = rs.getDate("date_joined");
    String email = rs.getString("email");
    long points = rs.getLong("points");
    String school = rs.getString("school");
    Note[] favoriteNotes = favoriteNoteService.getFavoriteNotesByUserId(pool, userId);
    Note[] uploadedNotes = noteService.getUploadedNotesByUserId(pool, userId);

    User user = new User.Builder()
                        .setId(userId)
                        .setOptionalDisplayProperties(displayPicture, displayName)
                        .setDateJoined(dateJoined)
                        .setEmail(email)
                        .setPoints(points)
                        .setOptionalSchool(school)
                        .setOptionalFavoriteNotes(favoriteNotes)
                        .setOptionalUploadedNotes(uploadedNotes)
                        .build();
    return user;
  }
}
