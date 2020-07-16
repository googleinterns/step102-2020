package com.google.starfish.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;  
import java.sql.ResultSet;  
import javax.sql.DataSource;

import com.mysql.cj.x.protobuf.MysqlxPrepare.Prepare;

public class MiscNoteLabelService extends GenericService {
  public ResultSet getByCompoundId(DataSource pool, long noteId, String label) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt = 
          "SELECT * "
        + "FROM starfish.misc_note_labels "
        + "WHERE `note_id`= ? AND "
        + "`label` = ? "
        + "LIMIT 1;";
      try (PreparedStatement getStmt = conn.prepareStatement(stmt)) {
        getStmt.setLong(1, noteId);
        getStmt.setString(1, label);
        ResultSet rs = getStmt.executeQuery();
        return rs;
      } 
    }
  }

  public ResultSet deleteByCompoundId(DataSource pool, long noteId, String label) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt = 
          "DELETE * "
        + "FROM starfish.misc_note_labels "
        + "WHERE `note_id`= ? AND "
        + "`label` = ? "
        + "LIMIT 1;";
      try (PreparedStatement getStmt = conn.prepareStatement(stmt)) {
        getStmt.setLong(1, noteId);
        getStmt.setString(1, label);
        ResultSet rs = getStmt.executeQuery();
        return rs;
      } 
    }
  }

  public void insertMiscNoteLabelById(DataSource pool, long noteId, String label) {
    try (Connection conn = pool.getConnection()) {
      try {
        conn.setAutoCommit(false);
        String stmt =
            "INSERT INTO misc_note_labels ( "
                + "note_d,"
                + "label ) "
          + "VALUES ( "
                + "?,"
                + "? ); ";
        try (PreparedStatement insertStmt = conn.prepareStatement(stmt)) {
          label.toLowerCase().trim();
          insertStmt.setLong(1, noteId);
          insertStmt.setString(1, label);
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
}
