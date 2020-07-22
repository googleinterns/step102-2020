package com.google.starfish.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;  
<<<<<<< HEAD
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
=======
import javax.sql.DataSource;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

/** Enum that holds label types */
enum Type {
  SCHOOL("School"),COURSE("Course"), MISC("Misc");

  private String type;

  public String getType() {
    return this.type;
  }

  private Type(String type) {
    this.type = type;
  }
}

/**
 * Service class for Labels Table
 */
public class LabelService extends TableService {

  private String LABELS = Table.LABELS.getSqlTable();

  public LabelService() {
    super(Table.LABELS);
  }

  /** Inserts new school label */
  public void insertSchoolLabel(DataSource pool, String school) {
    insertLabel(pool, school, Type.SCHOOL);
  }

  /** Inserts new course label */
  public void insertCourseLabel(DataSource pool, String course) {
    insertLabel(pool, course, Type.COURSE);
  }

  /** Inserts new misc label */
  public void insertMiscLabel(DataSource pool, String label) {
    insertLabel(pool, label, Type.MISC);
  }

  /** Returns a map of all school and course labels in the database */
  public HashMap<String, String[]> getAllSchoolAndCourseLabels(DataSource pool) {
    HashMap<String, String[]> organizedLabels = new HashMap<>();
    try (Connection conn = pool.getConnection()) {
      try {
        conn.setAutoCommit(false);
        String schoolsStmt = 
            "SELECT * " 
          + "FROM " + LABELS + " "
          + "WHERE type= \"" + Type.SCHOOL.getType() + "\"";
        String coursesStmt = 
            "SELECT * " 
          + "FROM " + LABELS + " "
          + "WHERE type= \"" + Type.COURSE.getType() + "\"";
        try (PreparedStatement schoolStmt = conn.prepareStatement(schoolsStmt); 
            PreparedStatement courseStmt = conn.prepareStatement(coursesStmt)) {
          ResultSet schoolResults = schoolStmt.executeQuery();
          ResultSet courseResults = courseStmt.executeQuery();
          conn.commit();
          String[] schools = createStringArrayOutOfResultSet(schoolResults, "title");
          String[] courses = createStringArrayOutOfResultSet(courseResults, "title");
          organizedLabels.put("schools", schools);
          organizedLabels.put("courses", courses);
          return organizedLabels;
>>>>>>> master
        }
      } catch(SQLException ex) {
        if (conn != null) {
          try {
            System.err.print("Transaction is being rolled back.");
            conn.rollback();
          } catch (SQLException excep) {
            System.err.print(excep);
<<<<<<< HEAD
          }
        }
      }
    } catch (SQLException ex) {
      System.err.print(ex);
    }
  }

  public void insertMiscLabel(DataSource pool, String label) {
=======
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

  private String[] createStringArrayOutOfResultSet(ResultSet rs, String stringColumn) throws SQLException {
    List<String> list = new ArrayList<>();
    while (rs.next()) {
      String thisResult = rs.getString(stringColumn);
      list.add(thisResult);
    }
    return list.toArray(new String[0]);
  }

  private void insertLabel(DataSource pool, String label, Type type) {
    if (label == null || type == null) return;
>>>>>>> master
    try (Connection conn = pool.getConnection()) {
      try {
        conn.setAutoCommit(false);
        String stmt =
<<<<<<< HEAD
            "INSERT INTO labels ( "
=======
            "INSERT INTO " + LABELS + " ( "
>>>>>>> master
                + "title,"
                + "type ) "
          + "VALUES ( "
                + "?,"
<<<<<<< HEAD
                + "'Misc' ); ";
        try (PreparedStatement insertStmt = conn.prepareStatement(stmt)) {
          label.toLowerCase().trim();
          insertStmt.setString(1, label);
=======
                + "? ); ";
        try (PreparedStatement insertStmt = conn.prepareStatement(stmt)) {
          insertStmt.setString(1, label.toLowerCase().trim());
          insertStmt.setString(2, type.getType());
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
}
