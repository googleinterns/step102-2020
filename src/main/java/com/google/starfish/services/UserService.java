package com.google.starfish.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;  
import javax.sql.DataSource;

enum Event {
  FAVORITE, DOWNLOAD, UNFAVORITE
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
    return modifyPoints(pool, userId, Event.FAVORITE);
  }

  /** Increase user points when a user's note gets downloaded */
  public boolean increasePointsOnDownload(DataSource pool, String userId) {
    return modifyPoints(pool, userId, Event.DOWNLOAD);
  }

  /** Decrease user points when a user's note gets unfavorited */
  public boolean decreasePointsOnUnfavorite(DataSource pool, String userId) {
    return modifyPoints(pool, userId, Event.UNFAVORITE);
  }

  /** Variably modify user points based on event */
  private boolean modifyPoints(DataSource pool, String userId, Event event) {
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
      case UNFAVORITE: 
        pointsModifier = -1 * FAVORITE_POINTS_MODIFIER;
        break;
      default:
        pointsModifier = FAVORITE_POINTS_MODIFIER;
    }
    return pointsModifier;
  }
}
