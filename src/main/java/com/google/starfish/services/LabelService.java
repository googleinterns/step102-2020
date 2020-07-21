package com.google.starfish.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;  
import javax.sql.DataSource;

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
}
