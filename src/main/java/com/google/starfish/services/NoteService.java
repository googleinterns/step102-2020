package com.google.starfish.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;  
import java.sql.ResultSet;  
import javax.sql.DataSource;
import java.util.ArrayList;

/**
 * Service class for Notes that allows retrieval of values stored as
 * instance variables on the Note class that aren't stored on the 
 * notes table in sql
 *
 */
public class NoteService extends GenericService {

  public ResultSet getById(DataSource pool, long id) throws SQLException {
    return super.getById(pool, id, Table.NOTES);
  }

  public boolean deleteById(DataSource pool, long id) throws SQLException {
    return super.deleteById(pool, id, Table.NOTES);
  }

  /** Gets the number of times a note has been favorited by note id */
  public long getNumFavoritesById(DataSource pool, long noteId) throws SQLException {
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

  /** Gets the misc labels attached to the note with the given note id */
  public String[] getMiscLabelsById(DataSource pool, long noteId) throws SQLException {
    try(Connection conn = pool.getConnection()) {
      String stmt =
          "SELECT label " 
        + "FROM " + Table.MISC_LABELS.getSqlTable() + " " 
        + "WHERE `note_id`=?;";
      try (PreparedStatement selectStmt = conn.prepareStatement(stmt)) {
        selectStmt.setLong(1, noteId);
        ResultSet rs = selectStmt.executeQuery();
        ArrayList<String> labels = new ArrayList<>();
        while(rs.next()) {
          labels.add(rs.getString("label"));
        }
        rs.close();
        return labels.toArray(new String[labels.size()]);
      }
    }
  }
}
