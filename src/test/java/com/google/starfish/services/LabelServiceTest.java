package com.google.starfish.services;

import com.google.starfish.models.Label;
import java.sql.SQLException;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import javax.sql.DataSource;
import java.util.HashMap;
import static com.ninja_squad.dbsetup.Operations.*;
import static org.junit.Assert.assertTrue;

import com.ninja_squad.dbsetup.DbSetup;
import com.ninja_squad.dbsetup.destination.DataSourceDestination;
import com.ninja_squad.dbsetup.operation.Operation;

@RunWith(JUnit4.class)
public class LabelServiceTest {

  private Constants constants = new Constants();
  private String LABELS = constants.LABELS;
  private DataSource pool = Constants.pool;
  private LabelService labelService = new LabelService();

  private static final boolean runTests = Constants.TEST_DB_NAME.equals("starfish_test");

  /** Clear DB, insert reference data, and insert 4 additional labels */
  @Before
  public void prepare() throws Exception {
    if(!runTests) throw new Exception("Wrong Test Database Name");
    Operation operation = getBeforeTestOperation();
    DbSetup dbSetup = new DbSetup(new DataSourceDestination(pool), operation);
    dbSetup.launch();
  }

  /** Test that a school label can be inserted */
  @Test
  public void testInsertSchoolLabel() throws SQLException {
    String testSchool = "mit";
    labelService.insertSchoolLabel(pool, testSchool);
    Label schoolLabel = labelService.getLabelByTitle(pool, testSchool);
    assertTrue(schoolLabel.getTitle().equals(testSchool));
    assertTrue(schoolLabel.getType().equals("School"));
  }

  /** Test that a course label can be inserted */
  @Test
  public void testInsertCourseLabel() throws SQLException {
    String testCourse = "linalg1141";
    labelService.insertCourseLabel(pool, testCourse);
    Label courseLabel = labelService.getLabelByTitle(pool, testCourse);
    assertTrue(courseLabel.getTitle().equals(testCourse));
    assertTrue(courseLabel.getType().equals("Course"));
  }

  /** Test that a misc label can be inserted */
  @Test
  public void testInsertMiscLabel() throws SQLException {
    String testLabel = "phyiscs";
    labelService.insertMiscLabel(pool, testLabel);
    Label miscLabel = labelService.getLabelByTitle(pool, testLabel);
    assertTrue(miscLabel.getTitle().equals(testLabel));
    assertTrue(miscLabel.getType().equals("Misc"));
  }

  /** Test that we can retrieve all school and course labels */
  @Test
  public void testGetAllSchoolAndCourseLabels() {
    HashMap<String, String[]> allSchoolAndCourseLabels = labelService.getAllSchoolAndCourseLabels(pool);
    int numSchoolLabels = allSchoolAndCourseLabels.get("schools").length;
    int numCourseLabels = allSchoolAndCourseLabels.get("courses").length;

    // There should be 3 schools, and 3 course labels
    assertTrue(numSchoolLabels == 3);
    assertTrue(numCourseLabels == 3);
  }

  /** Operation that should be run before every test */
  private Operation getBeforeTestOperation() {
    Operation operation =
        sequenceOf(
            CommonOperations.DELETE_ALL,
            CommonOperations.INSERT_REFERENCE_DATA,
            insertInto(LABELS)
                .columns("title", "type")
                .values("cornell", "School")
                .values("the university of florida", "School")
                .values("se2205", "Course")
                .values("bus1220", "Course")
                .build());
    return operation;
  }
}
