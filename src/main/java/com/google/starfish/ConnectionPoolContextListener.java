package com.google.starfish;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.sql.DataSource;

@WebListener("Creates a connection pool that is stored in the Servlet's context for later use.")
public class ConnectionPoolContextListener implements ServletContextListener {

  // All database credentials are stored in environment variables
  private static final String CLOUD_SQL_CONNECTION_NAME = System.getenv("CLOUD_SQL_CONNECTION_NAME");
  private static final String DB_USER = System.getenv("DB_USER");
  private static final String DB_PASS = System.getenv("DB_PASS");
  private static final String DB_NAME = System.getenv("DB_NAME");

  private DataSource createConnectionPool() {
    // The configuration object specifies behaviors for the connection pool.
    HikariConfig config = new HikariConfig();

    config.setJdbcUrl(String.format("jdbc:mysql:///%s", DB_NAME));
    config.setUsername(DB_USER);
    config.setPassword(DB_PASS);

    config.addDataSourceProperty("socketFactory", "com.google.cloud.sql.mysql.SocketFactory");
    config.addDataSourceProperty("cloudSqlInstance", CLOUD_SQL_CONNECTION_NAME);

    // maximumPoolSize limits the total number of concurrent connections this pool will keep.
    config.setMaximumPoolSize(5);

    // minimumIdle is the minimum number of idle connections Hikari maintains in the pool.
    config.setMinimumIdle(5);

    // setConnectionTimeout is the maximum number of milliseconds to wait for a connection checkout.
    config.setConnectionTimeout(10000); // 10 seconds

    // idleTimeout is the maximum amount of time a connection can sit in the pool. Connections that
    // sit idle for this many milliseconds are retried if minimumIdle is exceeded.
    config.setIdleTimeout(600000); // 10 minutes

    // maxLifetime is the maximum possible lifetime of a connection in the pool. Connections that
    // live longer than this many milliseconds will be closed and reestablished between uses.
    config.setMaxLifetime(1800000); // 30 minutes

    // Initialize the connection pool using the configuration object.
    DataSource pool = new HikariDataSource(config);

    return pool;
  }

  private void createLabelsTable(DataSource pool) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt =
          "CREATE TABLE IF NOT EXISTS labels ( "
              + "title VARCHAR(255) PRIMARY KEY,"
              + "type ENUM('School', 'Course', 'Other') NOT NULL );";
      try (PreparedStatement createTableStatement = conn.prepareStatement(stmt); ) {
        createTableStatement.execute();
      }
    }
  }

  private void createUsersTable(DataSource pool) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt =
          "CREATE TABLE IF NOT EXISTS users ( "
              + "id INT PRIMARY KEY AUTO_INCREMENT,"
              + "display_picture VARCHAR(255),"
              + "display_name VARCHAR(255),"
              + "date_joined DATE,"
              + "email VARCHAR(255) NOT NULL,"
              + "points INT NOT NULL,"
              + "school VARCHAR(255),"
              + "FOREIGN KEY (`school`)"
                  + "REFERENCES `labels` (`title`)"
                  + "ON UPDATE RESTRICT ON DELETE CASCADE );";
      try (PreparedStatement createTableStatement = conn.prepareStatement(stmt); ) {
        createTableStatement.execute();
      }
    }
  }
  
  private void createNotesTable(DataSource pool) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt =
          "CREATE TABLE IF NOT EXISTS notes ( "
              + "id INT PRIMARY KEY AUTO_INCREMENT,"
              + "author_id INT NOT NULL,"
              + "school VARCHAR(255) NOT NULL,"
              + "course VARCHAR(255) NOT NULL,"
              + "title VARCHAR(255) NOT NULL,"
              + "source_url VARCHAR(255) NOT NULL,"
              + "pdf_source VARCHAR(255),"
              + "date_created DATE NOT NULL,"
              + "num_downloads INT NOT NULL,"
              + "FOREIGN KEY (`author_id`)"
                  + "REFERENCES `users` (`id`)"
                  + "ON DELETE CASCADE,"
              + "FOREIGN KEY (`school`)"
                  + "REFERENCES `labels` (`title`),"
              + "FOREIGN KEY (`course`)"
                  + "REFERENCES `labels` (`title`),"
              + "CONSTRAINT pdf_or_source_url_not_null check ("
                  + "`source_url` IS NOT NULL OR `pdf_source` IS NOT NULL) );";
      try (PreparedStatement createTableStatement = conn.prepareStatement(stmt); ) {
        createTableStatement.execute();
      }
    }
  }

  private void createOtherNoteLabelsTable(DataSource pool) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt =
          "CREATE TABLE IF NOT EXISTS other_note_labels ( "
              + "note_id INT NOT NULL,"
              + "label VARCHAR(255) NOT NULL,"
              + "PRIMARY KEY (note_id, label),"
              + "FOREIGN KEY (`note_id`)"
                  + "REFERENCES `notes` (`id`)"
                  + "ON DELETE CASCADE,"
              + "FOREIGN KEY (`label`)"
                  + "REFERENCES `labels` (`title`)"
                  + "ON DELETE CASCADE );";
      try (PreparedStatement createTableStatement = conn.prepareStatement(stmt); ) {
        createTableStatement.execute();
      }
    }
  }
  
  private void createFavoriteNotesTable(DataSource pool) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt =
          "CREATE TABLE IF NOT EXISTS favorite_notes ( "
              + "user_id INT NOT NULL,"
              + "note_id INT NOT NULL,"
              + "PRIMARY KEY (user_id, note_id),"
              + "FOREIGN KEY (`user_id`)"
                  + "REFERENCES `users` (`id`)"
                  + "ON DELETE CASCADE,"
              + "FOREIGN KEY (`note_id`)"
                  + "REFERENCES `notes` (`id`)"
                  + "ON DELETE CASCADE );";
      try (PreparedStatement createTableStatement = conn.prepareStatement(stmt); ) {
        createTableStatement.execute();
      }
    }
  }

  /**
   * Creates every table in the Starfish DB Schema on the MySQL Instance.
   */
  private void createAllTablesInSchema(DataSource pool) throws SQLException {
    createLabelsTable(pool);
    createUsersTable(pool);
    createNotesTable(pool);
    createOtherNoteLabelsTable(pool);
    createFavoriteNotesTable(pool);
  }

  /**
   * This function is called when the Servlet is destroyed.
   */
  @Override
  public void contextDestroyed(ServletContextEvent event) {
    HikariDataSource pool = (HikariDataSource) event.getServletContext().getAttribute("my-pool");
    if (pool != null) {
      pool.close();
    }
  }

  /**
   * Called when the application starts and will safely create a connection pool
   * that can be used to connect to the Database and add it to the servlet context.
   */
  @Override
  public void contextInitialized(ServletContextEvent event) {
    ServletContext servletContext = event.getServletContext();
    DataSource pool = (DataSource) servletContext.getAttribute("my-pool");
    if (pool == null) {
      pool = createConnectionPool();
      servletContext.setAttribute("my-pool", pool);
    }
    try {
      createAllTablesInSchema(pool);
    } catch (SQLException ex) {
      throw new RuntimeException("Caught error connecting to DB, please try again later: ", ex);
    }
  }
}
