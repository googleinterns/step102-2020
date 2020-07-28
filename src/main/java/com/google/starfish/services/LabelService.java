package com.google.starfish.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;  
import javax.sql.DataSource;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import com.google.starfish.models.Label;

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

  /** Gets a label by title */
  public Label getLabelByTitle(DataSource pool, String title) throws SQLException {
     try (Connection conn = pool.getConnection()) {
      String stmt =
          "SELECT * "
        + "FROM " + LABELS + " "
        + "WHERE title=? "
        + "LIMIT 1;";

      try (PreparedStatement userStmt = conn.prepareStatement(stmt)) {
        userStmt.setString(1, title);
        ResultSet rs = userStmt.executeQuery();
        Label label = null;
        if (rs.next()) {
          label = constructLabelFromSqlResult(rs);
        }
        return label;
      }
    }
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
    try (Connection conn = pool.getConnection()) {
      try {
        conn.setAutoCommit(false);
        String stmt =
            "INSERT INTO " + LABELS + " ( "
                + "title,"
                + "type ) "
          + "VALUES ( "
                + "?,"
                + "? ); ";
        try (PreparedStatement insertStmt = conn.prepareStatement(stmt)) {
          insertStmt.setString(1, label.toLowerCase().trim());
          insertStmt.setString(2, type.getType());
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

  /** Constructs a label from sql result */
  private Label constructLabelFromSqlResult(ResultSet rs) throws SQLException {
    String title = rs.getString("title");
    String type = rs.getString("type");
    Label label = new Label(title, type);
    return label;
  }
}
