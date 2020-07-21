package com.google.starfish.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;  
import java.sql.ResultSet;  
import javax.sql.DataSource;
import java.util.List;
import java.util.ArrayList;

/**
 * Service class for MiscNoteLabels Table
 */
public class MiscNoteLabelService {

  private String MISC_LABELS = Table.MISC_LABELS.getSqlTable();

  /** Deletes misc note label by compound id */
  public boolean deleteRowByCompoundId(DataSource pool, long noteId, String label) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt = 
          "DELETE * "
        + "FROM " + MISC_LABELS + " "
        + "WHERE `note_id`= ? AND "
        + "`label` = ? "
        + "LIMIT 1;";
      try (PreparedStatement deleteStmt = conn.prepareStatement(stmt)) {
        deleteStmt.setLong(1, noteId);
        deleteStmt.setString(2, label);
        boolean deleted = deleteStmt.execute();
        return deleted;
      } 
    }
  }

  /** Inserts a misc note label by note id and label title */
  public void insertMiscNoteLabel(DataSource pool, long noteId, String label) {
    if (label == null) return;
    try (Connection conn = pool.getConnection()) {
      try {
        conn.setAutoCommit(false);
        String stmt =
            "INSERT INTO " + MISC_LABELS +  " ( "
                + "note_id,"
                + "label ) "
          + "VALUES ( "
                + "?,"
                + "? ); ";
        try (PreparedStatement insertStmt = conn.prepareStatement(stmt)) {
          insertStmt.setLong(1, noteId);
          insertStmt.setString(2, label.toLowerCase().trim());
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

  /** Returns an array of the most commonly used Misc labels on Notes */
  public String[] getMostUsedMiscLabels(DataSource pool) {
    List<String> labels = new ArrayList<>();
    String column1 = "label";
    String column2 = "times_used";
    try (Connection conn = pool.getConnection()) {
      try {
        conn.setAutoCommit(false);
        String stmt = 
            "SELECT ?, COUNT(*) AS ? " 
          + "FROM " + MISC_LABELS + " "
          + "GROUP BY ? "
          + "ORDER BY ? DESC;";
        try (PreparedStatement labelStmt = conn.prepareStatement(stmt)) {
          labelStmt.setString(1, column1);
          labelStmt.setString(2, column2);
          labelStmt.setString(3, column1);
          labelStmt.setString(4, column2);
          ResultSet rs = labelStmt.executeQuery();
          conn.commit();
          while (rs.next()) {
            String label = rs.getString(column1);
            labels.add(label);
          }
          return labels.toArray(new String[0]);
        }
      } catch(SQLException ex) {
        if (conn != null) {
          try {
            System.err.print("Transaction is being rolled back.");
            conn.rollback();
          } catch (SQLException excep) {
            System.err.print(excep);
            return null;
          }
        }
        return null;
      }
    } catch (SQLException ex) {
      System.err.print(ex);
      return null;
    }
  }

   /** Gets the misc labels attached to the note with the given note id */
  public String[] getMiscLabelsByNoteId(DataSource pool, long noteId) throws SQLException {
    try(Connection conn = pool.getConnection()) {
      String sqlQueryId = "label";
      String stmt =
          "SELECT " + sqlQueryId + " " 
        + "FROM " + MISC_LABELS + " " 
        + "WHERE `note_id`=?;";
      try (PreparedStatement selectStmt = conn.prepareStatement(stmt)) {
        selectStmt.setLong(1, noteId);
        ResultSet rs = selectStmt.executeQuery();
        List<String> labels = new ArrayList<>();
        while(rs.next()) {
          labels.add(rs.getString(sqlQueryId));
        }
        rs.close();
        return labels.toArray(new String[0]);
      }
    }
  }
}
