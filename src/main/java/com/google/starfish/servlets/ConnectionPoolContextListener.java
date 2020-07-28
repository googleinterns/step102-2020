package com.google.starfish.servlets;

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

  private final int MILLISECONDS_IN_SECOND = 1000;
  private final int SECONDS_IN_MINUTE = MILLISECONDS_IN_SECOND * 60;

  /** Configures database connection, opens pool, and returns pool as DataSource. */
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
    config.setConnectionTimeout(MILLISECONDS_IN_SECOND * 10);

    // idleTimeout is the maximum amount of time a connection can sit in the pool. Connections that
    // sit idle for this many milliseconds are retried if minimumIdle is exceeded.
    config.setIdleTimeout(SECONDS_IN_MINUTE * 10);

    // maxLifetime is the maximum possible lifetime of a connection in the pool. Connections that
    // live longer than this many milliseconds will be closed and reestablished between uses.
    config.setMaxLifetime(SECONDS_IN_MINUTE * 30);

    // Initialize the connection pool using the configuration object.
    DataSource pool = new HikariDataSource(config);

    return pool;
  }

  private void createLabelsTable(DataSource pool) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt =
          "CREATE TABLE IF NOT EXISTS labels ( "
              + "title VARCHAR(255) PRIMARY KEY,"
              + "type ENUM('School', 'Course', 'Misc') NOT NULL );";
      try (PreparedStatement createTableStatement = conn.prepareStatement(stmt)) {
        createTableStatement.execute();
      }
    }
  }

  private void createUsersTable(DataSource pool) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt =
          "CREATE TABLE IF NOT EXISTS users ( "
              + "id VARCHAR(255) PRIMARY KEY,"
              + "display_picture VARCHAR(255),"
              + "display_name VARCHAR(255),"
              + "date_joined DATE,"
              + "email VARCHAR(255) NOT NULL,"
              + "points INT NOT NULL,"
              + "school VARCHAR(255),"
              + "FOREIGN KEY (`school`)"
                  + "REFERENCES `labels` (`title`)"
                  + "ON UPDATE RESTRICT ON DELETE CASCADE );";
      try (PreparedStatement createTableStatement = conn.prepareStatement(stmt)) {
        createTableStatement.execute();
      }
    }
  }
  
  private void createNotesTable(DataSource pool) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt =
          "CREATE TABLE IF NOT EXISTS notes ( "
              + "id INT PRIMARY KEY AUTO_INCREMENT,"
              + "author_id VARCHAR(255) NOT NULL,"
              + "school VARCHAR(255) NOT NULL,"
              + "course VARCHAR(255) NOT NULL,"
              + "title VARCHAR(255) NOT NULL,"
              + "source_url VARCHAR(1000) NOT NULL,"
              + "pdf_source VARCHAR(1000),"
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
      try (PreparedStatement createTableStatement = conn.prepareStatement(stmt)) {
        createTableStatement.execute();
      }
    }
  }

  private void createMiscNoteLabelsTable(DataSource pool) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt =
          "CREATE TABLE IF NOT EXISTS misc_note_labels ( "
              + "note_id INT NOT NULL,"
              + "label VARCHAR(255) NOT NULL,"
              + "PRIMARY KEY (note_id, label),"
              + "FOREIGN KEY (`note_id`)"
                  + "REFERENCES `notes` (`id`)"
                  + "ON DELETE CASCADE,"
              + "FOREIGN KEY (`label`)"
                  + "REFERENCES `labels` (`title`)"
                  + "ON DELETE CASCADE );";
      try (PreparedStatement createTableStatement = conn.prepareStatement(stmt)) {
        createTableStatement.execute();
      }
    }
  }
  
  private void createFavoriteNotesTable(DataSource pool) throws SQLException {
    try (Connection conn = pool.getConnection()) {
      String stmt =
          "CREATE TABLE IF NOT EXISTS favorite_notes ( "
              + "user_id VARCHAR(255) NOT NULL,"
              + "note_id INT NOT NULL,"
              + "date DATE,"
              + "PRIMARY KEY (user_id, note_id),"
              + "FOREIGN KEY (`user_id`)"
                  + "REFERENCES `users` (`id`)"
                  + "ON DELETE CASCADE,"
              + "FOREIGN KEY (`note_id`)"
                  + "REFERENCES `notes` (`id`)"
                  + "ON DELETE CASCADE );";
      try (PreparedStatement createTableStatement = conn.prepareStatement(stmt)) {
        createTableStatement.execute();
      }
    }
  }

  /** Creates every table based on the Starfish DB Schema. */
  private void createAllTablesInSchema(DataSource pool) throws SQLException {
    createLabelsTable(pool);
    createUsersTable(pool);
    createNotesTable(pool);
    createMiscNoteLabelsTable(pool);
    createFavoriteNotesTable(pool);
  }

  /** Called when the Servlet is destroyed. */
  @Override
  public void contextDestroyed(ServletContextEvent event) {
    HikariDataSource pool = (HikariDataSource) event.getServletContext().getAttribute("my-pool");
    if (pool != null) {
      pool.close();
    }
  }

  /**
   * Called when the application starts to safely create a connection pool
   * that can be used to connect to the Database.
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
