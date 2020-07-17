package com.google.starfish.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;  
import java.sql.ResultSet;  
import javax.sql.DataSource;

/**
 * Service class for Notes that allows retrieval of values stored as
 * instance variables on the Note class that aren't stored on the 
 * notes table in sql
 *
 */
public class NoteService extends TableService {

  public NoteService() {
    super(Table.NOTES);
  }

  /** Gets the number of times a note has been favorited by note id */
  public long getNumFavoritesById(DataSource pool, long noteId) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt = 
          "SELECT COUNT(*) AS num_favorites "
        + "FROM starfish." + Table.FAVORITE_NOTES + " "
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
