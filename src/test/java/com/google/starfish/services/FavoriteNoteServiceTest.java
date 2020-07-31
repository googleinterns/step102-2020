package com.google.starfish.services;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Comparator;
import java.util.List;
import java.util.ArrayList;
import java.sql.SQLException;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import javax.sql.DataSource;
import static com.ninja_squad.dbsetup.Operations.*;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertEquals;

import com.google.starfish.services.FavoriteNoteService.Recency;
import com.google.starfish.models.Note;
import com.ninja_squad.dbsetup.DbSetup;
import com.ninja_squad.dbsetup.destination.DataSourceDestination;
import com.ninja_squad.dbsetup.operation.Operation;

@RunWith(JUnit4.class)
public class FavoriteNoteServiceTest {
  private Constants constants = new Constants();
  private String NOTES = constants.NOTES;
  private String LABELS = constants.LABELS;
  private String FAVORITE_NOTES = constants.FAVORITE_NOTES;
  private String USERS = constants.USERS;
  private DataSource pool = Constants.pool;
  private FavoriteNoteService favoriteNoteService = new FavoriteNoteService();

  // Comparator to sort Note arrays by id
  private final Comparator<Note> COMPARE_NOTES_BY_ID = new Comparator<Note>() {
    @Override
    public int compare(Note n1, Note n2) {
      return Long.compare(n1.getId(), n2.getId());
    }
  };

  // Variables to hold the indicated dates
  private Date TODAY;
  private Date THIS_WEEK;
  private Date THIS_MONTH;
  private Date ALL_TIME;

  // These variables represent the total number of rows that should be inserted 
  // into the FAVORITE_NOTES table where the data is as indicated.
  private final int NUM_TRENDING_NOTES_TODAY = 2;
  private final int NUM_TRENDING_NOTES_THIS_WEEK = NUM_TRENDING_NOTES_TODAY + 2;
  private final int NUM_TRENDING_NOTES_THIS_MONTH = NUM_TRENDING_NOTES_THIS_WEEK + 2;
  private final int NUM_TRENDING_NOTES_ALL_TIME = NUM_TRENDING_NOTES_THIS_MONTH + 1;

  private final String NEW_SCHOOL = "cornell university";
  private final String NEW_COURSE = "cs1300";
  private final String FIRST_NEW_USER_ID = Integer.toString(Integer.parseInt(constants.REFERENCE_USER_ID) + 1);
  private final String SECOND_NEW_USER_ID = Integer.toString(Integer.parseInt(constants.REFERENCE_USER_ID) + 2);
  private final int NUM_NOTES_WITH_NEW_SCHOOL_AND_COURSE = 3;

  // These arrays hold all notes in the database but are ordered by what's trending in the given timespan
  private Note[] notesOrderedByTrendingToday;
  private Note[] notesOrderedByTrendingThisWeek;
  private Note[] notesOrderedByTrendingThisMonth;
  private Note[] notesOrderedByTrendingAllTime;
  private Note[] notesOrderedByTrendingAllTimeFiltered;

  private static final boolean runTests = Constants.TEST_DB_NAME.equals("starfish_test");

  /** Set dates, Clear DB, insert reference data, and set notes */
  @Before
  public void prepare() throws Exception {
    if(!runTests) throw new Exception("Wrong Test Database Name");
    setDates();
    Operation operation = getBeforeTestOperation();
    DbSetup dbSetup = new DbSetup(new DataSourceDestination(pool), operation);
    dbSetup.launch();
    setAllTrendingNotes();
  }

  /** Test to see if we can get all notes favorited by a single user */
  @Test
  public void testGettingFavoriteNotesByUserId() throws SQLException, Exception {
    Note[] favoriteNotes = favoriteNoteService.getFavoriteNotesByUserId(pool, SECOND_NEW_USER_ID);
    if (favoriteNotes.length != 3) {
      throw new Exception("Expected 3 notes for user " + SECOND_NEW_USER_ID + ", got: " + favoriteNotes.length);
    } 
    Arrays.sort(favoriteNotes, COMPARE_NOTES_BY_ID);
    assertTrue(favoriteNotes[0].getId() == 2);
    assertTrue(favoriteNotes[1].getId() == 4);
    assertTrue(favoriteNotes[2].getId() == 6);
  }

  /** Test to see if we can get the number of times a particular note has been favorited */
  @Test
  public void testGettingNumFavoritesByNoteId() throws SQLException {
    long numFavorites = favoriteNoteService.getNumFavoritesByNoteId(pool, 1);
    assertTrue(numFavorites == 1);
  }

  /** Test to see if we can correctly retrieve the most trending notes today */
  @Test
  public void testGettingTrendingNotesToday() throws SQLException, Exception {
    HashMap<String, Note[]> separatedNotes = separateTrendingNotesAndSortNotTrendingById(notesOrderedByTrendingToday,
                                                                                         NUM_TRENDING_NOTES_TODAY);
    Note[] trendingNotes = separatedNotes.get("trending");
    Note[] notTrendingNotes = separatedNotes.get("notTrending");
    if (trendingNotes.length != NUM_TRENDING_NOTES_TODAY) {
      throw new Exception("Expected " + NUM_TRENDING_NOTES_TODAY + " trending notes today, got: " + trendingNotes.length);
    }
    // Verify that each element of both arrays is what we expect
    assertEquals(trendingNotes[0].getId(), 2);
    assertEquals(trendingNotes[1].getId(), 1);
    assertEquals(notTrendingNotes[0].getId(), 3);
    assertEquals(notTrendingNotes[1].getId(), 4);
    assertEquals(notTrendingNotes[2].getId(), 5);
    assertEquals(notTrendingNotes[3].getId(), 6);
    assertEquals(notTrendingNotes[4].getId(), 7);
  }

  /** Test to see if we can correctly retrieve the most trending notes this week */
  @Test 
  public void testGettingTrendingNotesThisWeek() throws SQLException, Exception {
    HashMap<String, Note[]> separatedNotes = separateTrendingNotesAndSortNotTrendingById(notesOrderedByTrendingThisWeek,
                                                                                         NUM_TRENDING_NOTES_THIS_WEEK);
    Note[] trendingNotes = separatedNotes.get("trending");
    Note[] notTrendingNotes = separatedNotes.get("notTrending");
    if (trendingNotes.length != NUM_TRENDING_NOTES_THIS_WEEK) {
      throw new Exception("Expected " + NUM_TRENDING_NOTES_THIS_WEEK + " trending notes today, got: " + trendingNotes.length);
    }
    // Verify that the important elements of both arrays are what we expect
    assertTrue(trendingNotes[0].getId() == 2 || trendingNotes[0].getId() ==  4);
    assertEquals(notTrendingNotes[0].getId(), 5);
    assertEquals(notTrendingNotes[1].getId(), 6);
    assertEquals(notTrendingNotes[2].getId(), 7);
  }

  /** Test to see if we can correctly retrieve the most trending notes this month */
  @Test
  public void testGettingTrendingNotesThisMonth() throws SQLException, Exception {
    HashMap<String, Note[]> separatedNotes = separateTrendingNotesAndSortNotTrendingById(notesOrderedByTrendingThisMonth,
                                                                                         NUM_TRENDING_NOTES_THIS_MONTH);
    Note[] trendingNotes = separatedNotes.get("trending");
    Note[] notTrendingNotes = separatedNotes.get("notTrending");
    if (trendingNotes.length != NUM_TRENDING_NOTES_THIS_MONTH) {
      throw new Exception("Expected " + NUM_TRENDING_NOTES_THIS_MONTH + " trending notes today, got: " + trendingNotes.length);
    }
    // Verify that the important elements of both arrays are what we expect
    assertTrue(trendingNotes[0].getId() == 2 || trendingNotes[0].getId() ==  4 || trendingNotes[0].getId() == 6);
    assertEquals(notTrendingNotes[0].getId(), 7);
  }

  /** Test to see if we can correctly retrieve the most trending notes all time */
  @Test
  public void testGettingTrendingNotesAllTime() throws SQLException, Exception {
    HashMap<String, Note[]> separatedNotes = separateTrendingNotesAndSortNotTrendingById(notesOrderedByTrendingAllTime,
                                                                                         NUM_TRENDING_NOTES_ALL_TIME);
    Note[] trendingNotes = separatedNotes.get("trending");
    Note[] notTrendingNotes = separatedNotes.get("notTrending");
    if (trendingNotes.length != NUM_TRENDING_NOTES_ALL_TIME) {
      throw new Exception("Expected " + NUM_TRENDING_NOTES_ALL_TIME + " trending notes today, got: " + trendingNotes.length);
    }
    // Verify that the important elements of both arrays are what we expect
    assertTrue(trendingNotes[0].getId() == 2 || trendingNotes[0].getId() ==  4 || trendingNotes[0].getId() == 6);
    assertEquals(notTrendingNotes.length, 0);
  }

  /** Test to see if we can correctly retrieve the most trending notes all time filtered by school and course */
  @Test
  public void testGettingTrendingNotesAllTimeFilteredBySchoolAndCourse() throws SQLException, Exception {
    int numFilteredNotes = NUM_TRENDING_NOTES_ALL_TIME - NUM_NOTES_WITH_NEW_SCHOOL_AND_COURSE;
    HashMap<String, Note[]> separatedNotes = separateTrendingNotesAndSortNotTrendingById(notesOrderedByTrendingAllTimeFiltered,
                                                                                         numFilteredNotes);
    Note[] trendingNotes = separatedNotes.get("trending");
    Note[] notTrendingNotes = separatedNotes.get("notTrending");
    if (trendingNotes.length != numFilteredNotes) {
      throw new Exception("Expected " + numFilteredNotes + " trending notes today, got: " + trendingNotes.length);
    }
    // Verify that the important elements of both arrays are what we expect
    assertTrue(trendingNotes[0].getId() ==  4 || trendingNotes[0].getId() == 6);
    assertEquals(notTrendingNotes.length, 0);
  }

  /** Gets and sets trending notes for various cases of Recency */
  private void setAllTrendingNotes() throws SQLException, Exception {
    notesOrderedByTrendingToday = extractNotesFrom2DArray(
        favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, Recency.TODAY, null, null));
    notesOrderedByTrendingThisWeek = extractNotesFrom2DArray(
        favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, Recency.THIS_WEEK, null, null));
    notesOrderedByTrendingThisMonth = extractNotesFrom2DArray(
        favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, Recency.THIS_MONTH, null, null));
    notesOrderedByTrendingAllTime = extractNotesFrom2DArray(
        favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, Recency.ALL_TIME, null, null));
    notesOrderedByTrendingAllTimeFiltered = extractNotesFrom2DArray(
        favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, Recency.ALL_TIME, NEW_SCHOOL, NEW_COURSE));

    if (notesOrderedByTrendingToday.length != 7) {
      throw new Exception("Expected 7 notes today, got: " + notesOrderedByTrendingToday.length);
    }
    if (notesOrderedByTrendingThisWeek.length != 7) {
      throw new Exception("Expected 7 notes this week, got: " + notesOrderedByTrendingThisWeek.length);
    }
    if (notesOrderedByTrendingThisMonth.length != 7) {
      throw new Exception("Expected 7 notes this month, got: " + notesOrderedByTrendingThisMonth.length);
    } 
    if (notesOrderedByTrendingAllTime.length != 7) {
      throw new Exception("Expected 7 notes all time, got: " + notesOrderedByTrendingAllTime.length);
    } 
    if (notesOrderedByTrendingAllTimeFiltered.length != 4) {
      throw new Exception("Expected 4 filtered notes all time, got: " + notesOrderedByTrendingAllTimeFiltered.length);
    } 
  }

  /** Separates the notes that are trending (i.e. have more than 0 favorites) from those that are not trending */
  private HashMap<String, Note[]> separateTrendingNotesAndSortNotTrendingById(Note[] notes, int numTrending) {
    HashMap<String, Note[]> separatedNotes = new HashMap<>();
    Note[] trendingNotes = Arrays.copyOfRange(notes, 0, numTrending);
    separatedNotes.put("trending", trendingNotes);
    if (numTrending < notes.length) {
      Note[] notTrendingNotes = Arrays.copyOfRange(notes, numTrending, notes.length);
      Arrays.sort(notTrendingNotes, COMPARE_NOTES_BY_ID);
      separatedNotes.put("notTrending", notTrendingNotes);
    } else {
      separatedNotes.put("notTrending", new Note[0]);
    }
    return separatedNotes;
  }

  /** Extracts note objects from 2D object array which in each element, holds a 2-element array where the
   *  first index is a note object and the second index is the number of favorites in a given timespan
   */
  private Note[] extractNotesFrom2DArray(Object[][] notesAndFavoritesInTimespan) {
    List<Note> notes = new ArrayList<>();
    for (Object[] noteAndFavorites : notesAndFavoritesInTimespan) {
      notes.add((Note) noteAndFavorites[0]);
    }
    return notes.toArray(new Note[0]);
  }

  /** Dynamically sets the dates as indicated */
  private void setDates() {
    Calendar cal = Calendar.getInstance();
    TODAY = new Date(cal.getTimeInMillis());
    cal.add(Calendar.DAY_OF_MONTH, -7);
    THIS_WEEK = new Date(cal.getTimeInMillis());
    cal.add(Calendar.DAY_OF_MONTH, -23);
    THIS_MONTH = new Date(cal.getTimeInMillis());
    cal.add(Calendar.YEAR, -100);
    ALL_TIME = new Date(cal.getTimeInMillis());
  }

  /** Operation that should be run before every test */
  private Operation getBeforeTestOperation() {
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
                  FIRST_NEW_USER_ID,
                  "test.url",
                  "Aradhya",
                  new Date(Calendar.getInstance().getTimeInMillis()),
                  "thisisntmyrealemail@gmail.com",
                  0,
                  constants.REFERENCE_SCHOOL)
                .values(
                  SECOND_NEW_USER_ID,
                  "test.url",
                  "Aradhya",
                  new Date(Calendar.getInstance().getTimeInMillis()),
                  "thisisntmyrealemail@gmail.com",
                  0,
                  constants.REFERENCE_SCHOOL)
                .build(),
            insertInto(LABELS)
                .columns("title", "type")
                .values(NEW_SCHOOL, "School")
                .values(NEW_COURSE, "Course")
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
                  TODAY,
                  0)
                .values(
                  2,
                  constants.REFERENCE_USER_ID,
                  constants.REFERENCE_SCHOOL,
                  constants.REFERENCE_COURSE,
                  "The Second Best Notes Ever",
                  "test.url",
                  "pdftest.url",
                  TODAY,
                  0)
                .values(
                  3,
                  constants.REFERENCE_USER_ID,
                  constants.REFERENCE_SCHOOL,
                  constants.REFERENCE_COURSE,
                  "The Third Best Notes Ever",
                  "test.url",
                  "pdftest.url",
                  THIS_WEEK,
                  0)
                .values(
                  4,
                  constants.REFERENCE_USER_ID,
                  NEW_SCHOOL,
                  NEW_COURSE,
                  "The Fourth Best Notes Ever",
                  "test.url",
                  "pdftest.url",
                  THIS_WEEK,
                  0)
                .values(
                  5,
                  constants.REFERENCE_USER_ID,
                  NEW_SCHOOL,
                  NEW_COURSE,
                  "The Fifth Best Notes Ever",
                  "test.url",
                  "pdftest.url",
                  THIS_MONTH,
                  0)
                .values(
                  6,
                  constants.REFERENCE_USER_ID,
                  NEW_SCHOOL,
                  NEW_COURSE,
                  "The Sixth Best Notes Ever",
                  "test.url",
                  "pdftest.url",
                  THIS_MONTH,
                  0)
                .values(
                  7,
                  constants.REFERENCE_USER_ID,
                  NEW_SCHOOL,
                  NEW_COURSE,
                  "The Seventh Best Notes Ever",
                  "test.url",
                  "pdftest.url",
                  ALL_TIME,
                  0)
                .build(),
            insertInto(FAVORITE_NOTES)
                .columns("user_id", "note_id", "date")
                .values(FIRST_NEW_USER_ID, 1, TODAY)
                .values(FIRST_NEW_USER_ID, 2, TODAY)
                .values(FIRST_NEW_USER_ID, 3, THIS_WEEK)
                .values(FIRST_NEW_USER_ID, 4, THIS_WEEK)
                .values(FIRST_NEW_USER_ID, 5, THIS_MONTH)
                .values(FIRST_NEW_USER_ID, 6, THIS_MONTH)
                .values(FIRST_NEW_USER_ID, 7, ALL_TIME)
                .values(SECOND_NEW_USER_ID, 2, TODAY)
                .values(SECOND_NEW_USER_ID, 4, THIS_WEEK)
                .values(SECOND_NEW_USER_ID, 6, THIS_MONTH)
                .build());
    return operation;
  }
}
