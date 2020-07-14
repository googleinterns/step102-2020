package com.google.starfish.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;  
import java.sql.ResultSet;  
import javax.sql.DataSource;

public class NoteService extends GenericService {

  public ResultSet getById(DataSource pool, long id) throws SQLException {
    return super.getById(pool, id, Table.NOTES);
  }

  public boolean deleteById(DataSource pool, long id) throws SQLException {
    return super.deleteById(pool, id, Table.NOTES);
  }

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
