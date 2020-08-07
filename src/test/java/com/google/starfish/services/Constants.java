package com.google.starfish.services;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import javax.sql.DataSource;

public class Constants {
  public final String LABELS = Table.LABELS.getSqlTable();
  public final String USERS = Table.USERS.getSqlTable();
  public final String NOTES = Table.NOTES.getSqlTable();
  public final String MISC_LABELS = Table.MISC_LABELS.getSqlTable();
  public final String FAVORITE_NOTES = Table.FAVORITE_NOTES.getSqlTable();
  public final String REFERENCE_USER_ID = "1";
  public final String REFERENCE_SCHOOL = "the university of western ontario";
  public final String REFERENCE_COURSE = "se2203";
  public static final DataSource pool = createConnectionPool();
  public static final String TEST_DB_NAME = "starfish_test";

  private static final String CLOUD_SQL_CONNECTION_NAME = "step102-2020:us-central1:step102-2020-mysql";
  private static final String TEST_DB_USER = "mastersf";
  private static final String TEST_DB_PASS = "starfish";
    
  private static final int MILLISECONDS_IN_SECOND = 1000;
  private static final int SECONDS_IN_MINUTE = MILLISECONDS_IN_SECOND * 60;

  private static DataSource createConnectionPool() {
    // The configuration object specifies behaviors for the connection pool.
    HikariConfig config = new HikariConfig();

    config.setJdbcUrl(String.format("jdbc:mysql:///%s", TEST_DB_NAME));
    config.setUsername(TEST_DB_USER);
    config.setPassword(TEST_DB_PASS);

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
}
