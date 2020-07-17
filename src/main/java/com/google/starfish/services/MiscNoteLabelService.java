package com.google.starfish.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;  
import java.sql.ResultSet;  
import javax.sql.DataSource;
import java.util.List;
import java.util.ArrayList;

public class MiscNoteLabelService {

  /** Gets mis note label by compound id */
  public ResultSet getRowByCompoundId(DataSource pool, long noteId, String label) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt = 
          "SELECT * "
        + "FROM misc_note_labels "
        + "WHERE `note_id`= ? AND "
        + "`label` = ? "
        + "LIMIT 1;";
      try (PreparedStatement getStmt = conn.prepareStatement(stmt)) {
        getStmt.setLong(1, noteId);
        getStmt.setString(2, label);
        ResultSet rs = getStmt.executeQuery();
        return rs;
      } 
    }
  }

  /** Deletes misc note label by compound id */
  public boolean deleteRowByCompoundId(DataSource pool, long noteId, String label) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt = 
          "DELETE * "
        + "FROM misc_note_labels "
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
            "INSERT INTO misc_note_labels ( "
                + "note_id,"
                + "label ) "
          + "VALUES ( "
                + "?,"
                + "? ); ";
        try (PreparedStatement insertStmt = conn.prepareStatement(stmt)) {
          insertStmt.setLong(1, noteId);
          insertStmt.setString(2, label.toLowerCase().trim());
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

   /** Gets the misc labels attached to the note with the given note id */
  public String[] getMiscLabelsByNoteId(DataSource pool, long noteId) throws SQLException {
    try(Connection conn = pool.getConnection()) {
      String stmt =
          "SELECT label " 
        + "FROM " + Table.MISC_LABELS.getSqlTable() + " " 
        + "WHERE `note_id`=?;";
      try (PreparedStatement selectStmt = conn.prepareStatement(stmt)) {
        selectStmt.setLong(1, noteId);
        ResultSet rs = selectStmt.executeQuery();
        List<String> labels = new ArrayList<>();
        while(rs.next()) {
          labels.add(rs.getString("label"));
        }
        rs.close();
        return labels.toArray(new String[labels.size()]);
      }
    }
  }
}
