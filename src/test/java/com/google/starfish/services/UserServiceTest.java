package com.google.starfish.services;

import com.google.starfish.models.Note;
import java.util.Date;
import java.sql.SQLException;
import java.util.Calendar;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import java.sql.ResultSet;
import javax.sql.DataSource;
import static com.ninja_squad.dbsetup.Operations.*;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import com.ninja_squad.dbsetup.DbSetup;
import com.ninja_squad.dbsetup.destination.DataSourceDestination;
import com.ninja_squad.dbsetup.operation.Operation;

@RunWith(JUnit4.class)
public class UserServiceTest implements ServletContextListener {

  private DataSource pool = Constants.pool;
  private String USERS = Constants.USERS;
  private UserService userService = new UserService();

  private static final boolean runTests = DB_NAME.equals("starfish_test");

  @Before
  public void prepare() throws Exception {
    Operation operation =
        sequenceOf(
            CommonOperations.DELETE_ALL,
            CommonOperations.INSERT_REFERENCE_DATA,
            insertInto(USERS)
                .columns(
                  "id",
                  "display_picture",
                  "display_name",
                  "date_joined",
                  "email",
                  "points",
                  "school")
                .values(
                  Constants.REFERENCE_USER_ID,
                  "default_display_picture",
                  "Joe",
                  new Date(Calendar.getInstance().getTimeInMillis()),
                  "joe@example.com",
                  0,
                  Types.VARCHAR)
                .build());
    DbSetup dbSetup = new DbSetup(new DataSourceDestination(pool), operation);
    dbSetup.launch();
  }

  @Test
  public void testIncreasePointsOnDownload() throws SQLException {
    if(runTests) {
      userService.increasePointsOnDownload(pool, Constants.REFERENCE_USER_ID);
      // Check that user has 5 points
    }
  }

  @Test
  public void testIncreasePointsOnFavorite() throws SQLException {
    if(runTests) {
      userService.increasePointOnFavorite(pool, Constants.REFERENCE_USER_ID);
      // Check that user has 8 points
    }
  }

  @Test
  public void testDecreasePointsOnUnfavorite() throws SQLException {
    if(runTests) {
      userService.decreasePointsOnUnfavorite(pool, Constants.REFERENCE_USER_ID);
      // Check that user has 5 points
    }
  }

}