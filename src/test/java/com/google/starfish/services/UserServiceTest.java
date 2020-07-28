package com.google.starfish.services;

import com.google.starfish.models.User;
import java.sql.SQLException;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import javax.sql.DataSource;
import static com.ninja_squad.dbsetup.Operations.*;
import static org.junit.Assert.assertEquals;

import com.ninja_squad.dbsetup.DbSetup;
import com.ninja_squad.dbsetup.destination.DataSourceDestination;
import com.ninja_squad.dbsetup.operation.Operation;

@RunWith(JUnit4.class)
public class UserServiceTest {

  private Constants constants = new Constants();
  private DataSource pool = Constants.pool;
  private UserService userService = new UserService();

  private static final boolean runTests = Constants.TEST_DB_NAME.equals("starfish_test");

  @Before
  public void prepare() throws Exception {
    Operation operation =
        sequenceOf(
            CommonOperations.DELETE_ALL,
            CommonOperations.INSERT_REFERENCE_DATA);
    DbSetup dbSetup = new DbSetup(new DataSourceDestination(pool), operation);
    dbSetup.launch();
  }

  @Test
  public void testIncreasePointsOnDownload() throws SQLException, Exception {
    if(!runTests) throw new Exception("Wrong Test Database Name");

    User userBeforeOperation = userService.getUserById(pool, constants.REFERENCE_USER_ID);
    long numPointsBeforeOperation = userBeforeOperation.getPoints();

    userService.increasePointsOnDownload(pool, constants.REFERENCE_USER_ID);

    User userAfterOperation = userService.getUserById(pool, constants.REFERENCE_USER_ID);
    long numPointsAfterOperation = userAfterOperation.getPoints();

    assertEquals(numPointsBeforeOperation + userService.DOWNLOAD_POINTS_MODIFIER, numPointsAfterOperation);
  }

  @Test
  public void testIncreasePointsOnFavorite() throws SQLException, Exception {
    if(!runTests) throw new Exception("Wrong Test Database Name");

    User userBeforeOperation = userService.getUserById(pool, constants.REFERENCE_USER_ID);
    long numPointsBeforeOperation = userBeforeOperation.getPoints();

    userService.increasePointsOnFavorite(pool, constants.REFERENCE_USER_ID);

    User userAfterOperation = userService.getUserById(pool, constants.REFERENCE_USER_ID);
    long numPointsAfterOperation = userAfterOperation.getPoints();

    assertEquals(numPointsBeforeOperation + userService.FAVORITE_POINTS_MODIFIER, numPointsAfterOperation);
  }

  @Test
  public void testDecreasePointsOnUnfavorite() throws SQLException, Exception {
    if(!runTests) throw new Exception("Wrong Test Database Name");

    User userBeforeOperation = userService.getUserById(pool, constants.REFERENCE_USER_ID);
    long numPointsBeforeOperation = userBeforeOperation.getPoints();

    userService.increasePointsOnFavorite(pool, constants.REFERENCE_USER_ID);

    User userAfterOperation = userService.getUserById(pool, constants.REFERENCE_USER_ID);
    long numPointsAfterOperation = userAfterOperation.getPoints();

    assertEquals(numPointsBeforeOperation - userService.FAVORITE_POINTS_MODIFIER, numPointsAfterOperation);
  }
}
