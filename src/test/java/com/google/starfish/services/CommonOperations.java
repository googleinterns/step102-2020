package com.google.starfish.services;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.sql.DataSource;

public class CommonOperations {

  public static void deleteAll(DataSource pool) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      Statement statement = conn.createStatement();
      statement.addBatch("DELETE FROM favorite_notes;");
      statement.addBatch("DELETE FROM misc_note_labels;");
      statement.addBatch("DELETE FROM labels;");
      statement.addBatch("DELETE FROM users;");
      statement.addBatch("DELETE FROM notes;");
      statement.executeBatch();
    }
  }
}