package com.google.starfish.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;  
import java.sql.ResultSet;  
import javax.sql.DataSource;

public class LabelService extends GenericService {
  public ResultSet getById(DataSource pool, long id) throws SQLException {
    return super.getById(pool, id, Table.LABELS);
  }

  public boolean deleteById(DataSource pool, long id) throws SQLException {
    return super.deleteById(pool, id, Table.LABELS);
  }

  public void insertSchoolLabel(DataSource pool, String school) {
    try (Connection conn = pool.getConnection()) {
      try {
        conn.setAutoCommit(false);
        String stmt =
            "INSERT INTO labels ( "
                + "title,"
                + "type ) "
          + "VALUES ( "
                + "?,"
                + "'School' ); ";
        try (PreparedStatement insertStmt = conn.prepareStatement(stmt)) {
          school.toLowerCase().trim();
          insertStmt.setString(1, school);
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

  public void insertCourseLabel(DataSource pool, String course) {
    try (Connection conn = pool.getConnection()) {
      try {
        conn.setAutoCommit(false);
        String stmt =
            "INSERT INTO labels ( "
                + "title,"
                + "type ) "
          + "VALUES ( "
                + "?,"
                + "'Course' ); ";
        try (PreparedStatement insertStmt = conn.prepareStatement(stmt)) {
          course.toLowerCase().trim();
          insertStmt.setString(1, course);
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

  public void insertMiscLabel(DataSource pool, String label) {
    try (Connection conn = pool.getConnection()) {
      try {
        conn.setAutoCommit(false);
        String stmt =
            "INSERT INTO labels ( "
                + "title,"
                + "type ) "
          + "VALUES ( "
                + "?,"
                + "'Misc' ); ";
        try (PreparedStatement insertStmt = conn.prepareStatement(stmt)) {
          label.toLowerCase().trim();
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
