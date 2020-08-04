package com.google.starfish.services;

import java.util.Date;
import java.util.Calendar;
import java.sql.SQLException;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import javax.sql.DataSource;
import java.util.Arrays;
import static com.ninja_squad.dbsetup.Operations.*;
import static org.junit.Assert.assertTrue;

import com.ninja_squad.dbsetup.DbSetup;
import com.ninja_squad.dbsetup.destination.DataSourceDestination;
import com.ninja_squad.dbsetup.operation.Operation;

@RunWith(JUnit4.class)
public class MiscNoteLabelServiceTest {
  private Constants constants = new Constants();
  private String LABELS = constants.LABELS;
  private String NOTES = constants.NOTES;
  private String MISC_LABELS = constants.MISC_LABELS;
  private DataSource pool = Constants.pool;
  private MiscNoteLabelService miscNoteLabelService = new MiscNoteLabelService();

  private final String MISC_LABEL_ONE = "best";
  private final String MISC_LABEL_TWO = "hard";
  private final String MISC_LABEL_THREE = "math";

  private static final boolean runTests = Constants.TEST_DB_NAME.equals("starfish_test");

  /** Clear DB and insert reference data */
  @Before
  public void prepare() throws Exception {
    if(!runTests) throw new Exception("Wrong Test Database Name");
    Operation operation = getBeforeTestOperation();
    DbSetup dbSetup = new DbSetup(new DataSourceDestination(pool), operation);
    dbSetup.launch();
  }

  /** Test that most used labels are retrieved in order */
  @Test
  public void testGettingMostUsedMiscLabels() throws SQLException, Exception {
    String[] mostUsedLabels = miscNoteLabelService.getMostUsedMiscLabels(pool);
    if (mostUsedLabels.length != 3) throw new Exception("Didn't retrieve correct number of misc labels.");
    String mostUsedLabel = mostUsedLabels[0];
    String secondMostUsedLabel = mostUsedLabels[1];
    String thirdMostUsedLabel = mostUsedLabels[2];
    assertTrue(mostUsedLabel.equals(MISC_LABEL_ONE)); 
    assertTrue(secondMostUsedLabel.equals(MISC_LABEL_TWO));
    assertTrue(thirdMostUsedLabel.equals(MISC_LABEL_THREE));
  }

  /** Test that all misc labels associated with a specific note can be retrieved */
  @Test
  public void testGettingMiscLabelsByNoteId() throws SQLException, Exception {
    String[] miscLabels = miscNoteLabelService.getMiscLabelsByNoteId(pool, 2);
    if (miscLabels.length != 2) throw new Exception("Didn't retrieve correct number of misc labels.");
    // Sort the array alphabetically so we know what to expect
    Arrays.sort(miscLabels);
    String firstMiscLabel = miscLabels[0];
    String secondMiscLabel = miscLabels[1];
    assertTrue(firstMiscLabel.equals(MISC_LABEL_ONE));
    assertTrue(secondMiscLabel.equals(MISC_LABEL_TWO));
  }

  /** Assembles and returns the pre-test operations for this test class */
  private Operation getBeforeTestOperation() {
    Operation operation =
        sequenceOf(
            CommonOperations.DELETE_ALL,
            CommonOperations.INSERT_REFERENCE_DATA,
            insertInto(LABELS)
                .columns("title", "type")
                .values(MISC_LABEL_ONE, "Misc")
                .values(MISC_LABEL_TWO, "Misc")
                .values(MISC_LABEL_THREE, "Misc")
                .build(),
            insertInto(NOTES)
                .columns(
                  "id",
                  "author_id",
                  "school",
                  "course",
                  "title",
                  "source_url",
                  "pdf_source",
                  "date_created",
                  "num_downloads")
                .values(
                  1,
                  constants.REFERENCE_USER_ID,
                  constants.REFERENCE_SCHOOL,
                  constants.REFERENCE_COURSE,
                  "The Best Notes Ever",
                  "test.url",
                  "pdftest.url",
                  new Date(Calendar.getInstance().getTimeInMillis()),
                  0)
                .values(
                  2,
                  constants.REFERENCE_USER_ID,
                  constants.REFERENCE_SCHOOL,
                  constants.REFERENCE_COURSE,
                  "The Second Best Notes Ever",
                  "test.url",
                  "pdftest.url",
                  new Date(Calendar.getInstance().getTimeInMillis()),
                  0)
                .values(
                  3,
                  constants.REFERENCE_USER_ID,
                  constants.REFERENCE_SCHOOL,
                  constants.REFERENCE_COURSE,
                  "The Third Best Notes Ever",
                  "test.url",
                  "pdftest.url",
                  new Date(Calendar.getInstance().getTimeInMillis()),
                  0)
                .build(),
            insertInto(MISC_LABELS)
                .columns("note_id", "label")
                .values(1, MISC_LABEL_ONE)
                .values(1, MISC_LABEL_TWO)
                .values(1, MISC_LABEL_THREE)
                .values(2, MISC_LABEL_ONE)
                .values(2, MISC_LABEL_TWO)
                .values(3, MISC_LABEL_ONE)
                .build());
    return operation;
  }
}
