package com.google.starfish.services;

import java.sql.ResultSet;
import javax.sql.DataSource;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.SQLException;

/** Enum that holds starfishDB sql tables as strings */
enum Table {
  USERS("users"), NOTES("notes"), LABELS("labels"), FAVORITE_NOTES("favorite_notes"), MISC_LABELS("misc_note_labels");

  private String sqlTable;

  public String getSqlTable() {
    return this.sqlTable;
  }

  private Table(String sqlTable) {
    this.sqlTable = sqlTable;
  }
}

/** 
 * A generic service class that provides the functionality to 
 * get and delete row by id in tables with non-compound keys 
 */
public class TableService {

  String sqlTable;

  public TableService(Table sqlTable) {
    this.sqlTable = sqlTable.getSqlTable();
  }

  /** Deletes row by long id from sql */
  public boolean deleteRowById(DataSource pool, long id) {
    try (Connection conn = pool.getConnection()) {
      try {
        conn.setAutoCommit(false);
        String stmt = 
            "DELETE * "
          + "FROM " + this.sqlTable + " "
          + "WHERE `id`= ? "
          + "LIMIT 1;";
        try (PreparedStatement deleteStmt = conn.prepareStatement(stmt)) {
          deleteStmt.setLong(1, id);
          boolean deleted = deleteStmt.execute();
          conn.commit();
          return deleted;
        } 
      } catch (SQLException ex) {
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

  /** Deletes row by string id from sql */
  public boolean deleteRowById(DataSource pool, String id) {
    try (Connection conn = pool.getConnection()) {
      try {
        conn.setAutoCommit(false);
        String stmt = 
            "DELETE * "
          + "FROM " + this.sqlTable + " "
          + "WHERE `id`= ? "
          + "LIMIT 1;";
        try (PreparedStatement deleteStmt = conn.prepareStatement(stmt)) {
          deleteStmt.setString(1, id);
          boolean deleted = deleteStmt.execute();
          conn.commit();
          return deleted;
        } 
      } catch (SQLException ex) {
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
}
