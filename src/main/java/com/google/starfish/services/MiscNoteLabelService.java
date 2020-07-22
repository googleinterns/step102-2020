package com.google.starfish.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;  
import java.sql.ResultSet;  
import javax.sql.DataSource;
<<<<<<< HEAD

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
=======
import java.util.List;
import java.util.ArrayList;
import com.google.starfish.services.TableService;

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
>>>>>>> master
      } 
    }
  }

<<<<<<< HEAD
  public void insertMiscNoteLabelById(DataSource pool, long noteId, String label) {
=======
  /** Inserts a misc note label by note id and label title */
  public void insertMiscNoteLabel(DataSource pool, long noteId, String label) {
    if (label == null) return;
>>>>>>> master
    try (Connection conn = pool.getConnection()) {
      try {
        conn.setAutoCommit(false);
        String stmt =
<<<<<<< HEAD
            "INSERT INTO misc_note_labels ( "
=======
            "INSERT INTO " + MISC_LABELS +  " ( "
>>>>>>> master
                + "note_id,"
                + "label ) "
          + "VALUES ( "
                + "?,"
                + "? ); ";
        try (PreparedStatement insertStmt = conn.prepareStatement(stmt)) {
<<<<<<< HEAD
          label.toLowerCase().trim();
          insertStmt.setLong(1, noteId);
          insertStmt.setString(2, label);
          System.out.println(insertStmt);
=======
          insertStmt.setLong(1, noteId);
          insertStmt.setString(2, label.toLowerCase().trim());
>>>>>>> master
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
<<<<<<< HEAD
=======

  /** Returns an array of the most commonly used Misc labels on Notes */
  public String[] getMostUsedMiscLabels(DataSource pool /* TODO: , String school, String course */) {
    List<String> labels = new ArrayList<>();
    String column1 = "label";
    String column2 = "times_used";
    try (Connection conn = pool.getConnection()) {
      try {
        conn.setAutoCommit(false);
        String stmt = 
            "SELECT " + column1 + ", COUNT(*) AS " + column2 + " " 
          + "FROM " + MISC_LABELS + " "
          // TODO: Only consider common labels for given `school` and `course`
          + "GROUP BY " + column1 + " "
          + "ORDER BY " + column2 + " DESC;";
        try (PreparedStatement labelStmt = conn.prepareStatement(stmt)) {
          ResultSet rs = labelStmt.executeQuery();
          conn.commit();
          while (rs.next()) {
            labels.add(rs.getString(column1));
          }
          rs.close();
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
>>>>>>> master
}
