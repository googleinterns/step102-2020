package com.google.starfish.services;

import java.util.Date;
import java.util.Calendar;
import java.util.Arrays;
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
  private Date TODAY = getToday();
  private Date THIS_WEEK = getThisWeek();
  private Date THIS_MONTH = getThisMonth();
  private Date ALL_TIME = getAllTime();

  private final String NEW_SCHOOL = "cornell university";
  private final String NEW_COURSE = "cs1300";
  private final String FIRST_NEW_USER_ID = Integer.toString(Integer.parseInt(constants.REFERENCE_USER_ID) + 1);
  private final String SECOND_NEW_USER_ID = Integer.toString(Integer.parseInt(constants.REFERENCE_USER_ID) + 2);

  private final int NUM_NOTES_INSERTABLE = 7;
  private final Note[] NOTES_INSERTABLE = initializeInsertableNotes();
  private final Note[] NOTES_EXPECTED_TODAY = initializeNotesToday(NOTES_INSERTABLE);
  private final Note[] NOTES_EXPECTED_THIS_WEEK = initializeNotesThisWeek(NOTES_INSERTABLE);
  private final Note[] NOTES_EXPECTED_THIS_MONTH = initializeNotesThisMonth(NOTES_INSERTABLE);
  private final Note[] NOTES_EXPECTED_ALL_TIME = initializeNotesAllTime(NOTES_INSERTABLE);
  private final Note[] NOTES_EXPECTED_ALL_TIME_FILTERED = initializeNotesAllTimeFiltered(NOTES_INSERTABLE);
  private final Note[] NOTES_EXCPECTED_SECOND_USER = initializeNotesExpectedForSecondNewUser(NOTES_INSERTABLE);

  private static final boolean runTests = Constants.TEST_DB_NAME.equals("starfish_test");

  /** Set dates, Clear DB, insert reference data, and set notes */
  @Before
  public void prepare() throws Exception {
    if(!runTests) throw new Exception("Wrong Test Database Name");
    Operation operation = getBeforeTestOperation();
    DbSetup dbSetup = new DbSetup(new DataSourceDestination(pool), operation);
    dbSetup.launch();
  }

  /** Test to see if we can get all notes favorited by a single user */
  @Test
  public void testGettingFavoriteNotesByUserId() throws SQLException, Exception {
    Note[] favoriteNotes = favoriteNoteService.getFavoriteNotesByUserId(pool, SECOND_NEW_USER_ID);
    if (favoriteNotes.length != 3) {
      throw new Exception("Expected 3 notes for user " + SECOND_NEW_USER_ID + ", got: " + favoriteNotes.length);
    } 
    Arrays.sort(favoriteNotes, COMPARE_NOTES_BY_ID);
    assertTrue(Arrays.equals(favoriteNotes, NOTES_EXCPECTED_SECOND_USER));
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
    Note[] notesOrderedByTrendingToday = extractNotesFrom2DArray(
        favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, Recency.TODAY, null, null));
    if (notesOrderedByTrendingToday.length != NOTES_EXPECTED_TODAY.length) {
      throw new Exception("Expected " + NOTES_EXPECTED_TODAY.length + " notes today, got: " + notesOrderedByTrendingToday.length);
    }
    assertTrue(Arrays.equals(notesOrderedByTrendingToday, NOTES_EXPECTED_TODAY));
  }

  /** Test to see if we can correctly retrieve the most trending notes this week */
  @Test 
  public void testGettingTrendingNotesThisWeek() throws SQLException, Exception {
    Note[] notesOrderedByTrendingThisWeek = extractNotesFrom2DArray(
        favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, Recency.THIS_WEEK, null, null));
    if (notesOrderedByTrendingThisWeek.length != NOTES_EXPECTED_THIS_WEEK.length) {
      throw new Exception("Expected " + NOTES_EXPECTED_THIS_WEEK.length + " notes this week, got: " + notesOrderedByTrendingThisWeek.length);
    }
    assertTrue(Arrays.equals(notesOrderedByTrendingThisWeek, NOTES_EXPECTED_THIS_WEEK));
  }

  /** Test to see if we can correctly retrieve the most trending notes this month */
  @Test
  public void testGettingTrendingNotesThisMonth() throws SQLException, Exception {
    Note[] notesOrderedByTrendingThisMonth = extractNotesFrom2DArray(
        favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, Recency.THIS_MONTH, null, null));
    if (notesOrderedByTrendingThisMonth.length != NOTES_EXPECTED_THIS_MONTH.length) {
      throw new Exception("Expected " + NOTES_EXPECTED_THIS_MONTH.length + " notes this month, got: " + notesOrderedByTrendingThisMonth.length);
    } 
    assertTrue(Arrays.equals(notesOrderedByTrendingThisMonth, NOTES_EXPECTED_THIS_MONTH));
  }

  /** Test to see if we can correctly retrieve the most trending notes all time */
  @Test
  public void testGettingTrendingNotesAllTime() throws SQLException, Exception {
    Note[] notesOrderedByTrendingAllTime = extractNotesFrom2DArray(
        favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, Recency.ALL_TIME, null, null));
    if (notesOrderedByTrendingAllTime.length != NOTES_EXPECTED_ALL_TIME.length) {
      throw new Exception("Expected " + NOTES_EXPECTED_ALL_TIME.length + " notes all time, got: " + notesOrderedByTrendingAllTime.length);
    } 
    assertTrue(Arrays.equals(notesOrderedByTrendingAllTime, NOTES_EXPECTED_ALL_TIME));
  }

  /** Test to see if we can correctly retrieve the most trending notes all time filtered by school and course */
  @Test
  public void testGettingTrendingNotesAllTimeFilteredBySchoolAndCourse() throws SQLException, Exception {
    Note[] notesOrderedByTrendingAllTimeFiltered = extractNotesFrom2DArray(
        favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, Recency.ALL_TIME, NEW_SCHOOL, NEW_COURSE));
    if (notesOrderedByTrendingAllTimeFiltered.length != NOTES_EXPECTED_ALL_TIME_FILTERED.length) {
      throw new Exception("Expected " + NOTES_EXPECTED_ALL_TIME_FILTERED.length + " filtered notes all time, got: " + notesOrderedByTrendingAllTimeFiltered.length);
    } 
    assertTrue(Arrays.equals(notesOrderedByTrendingAllTimeFiltered, NOTES_EXPECTED_ALL_TIME_FILTERED));
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

  private Date getToday() {
    Calendar cal = Calendar.getInstance();
    return new Date(cal.getTimeInMillis());
  }

  private Date getThisWeek() {
    Calendar cal = Calendar.getInstance();
    cal.add(Calendar.DAY_OF_MONTH, -7);
    return new Date(cal.getTimeInMillis());
  }

  private Date getThisMonth() {
    Calendar cal = Calendar.getInstance();
    cal.add(Calendar.DAY_OF_MONTH, -30);
    return new Date(cal.getTimeInMillis());
  }

  private Date getAllTime() {
    Calendar cal = Calendar.getInstance();
    cal.add(Calendar.YEAR, -100);
    return new Date(cal.getTimeInMillis());
  }

  /** Initializes the notes to be inserted into test DB */
  private Note[] initializeInsertableNotes() {
    List<Note> notesList = new ArrayList<>();
    for (long i = 1; i <= NUM_NOTES_INSERTABLE; i++) {
      String school = i >= 4 ? NEW_SCHOOL: constants.REFERENCE_SCHOOL;
      String course = i >= 4 ? NEW_COURSE: constants.REFERENCE_COURSE;
      long numFavorites = i % 2 == 0 ? 2: 1;
      Note newNote = new Note.Builder()
                         .setId(i)
                         .setAuthorId(constants.REFERENCE_USER_ID)
                         .setRequiredLabels(school, course)
                         .setNoteTitle("default")
                         .setSourceUrl("default")
                         .setOptionalPdfSource("default")
                         .setDateCreated(new java.sql.Date(TODAY.getTime()))
                         .setNumDownloads(0)
                         .setNumFavorites(numFavorites)
                         .setMiscLabels(new String[0])
                         .build();
      notesList.add(newNote);
    }
    return notesList.toArray(new Note[0]);
  }

  /** Generate array of expected notes today based on insertable notes */
  private Note[] initializeNotesToday(Note[] insertableNotes) {
    Note[] notes = new Note[] {insertableNotes[1],
                               insertableNotes[0],
                               insertableNotes[2],
                               insertableNotes[3],
                               insertableNotes[4],
                               insertableNotes[5],
                               insertableNotes[6]};
    return notes;
  }

  /** Generate array of expected notes this week based on insertable notes */
  private Note[] initializeNotesThisWeek(Note[] insertableNotes) {
    Note[] notes = new Note[] {insertableNotes[1],
                               insertableNotes[3],
                               insertableNotes[0],
                               insertableNotes[2],
                               insertableNotes[4],
                               insertableNotes[5],
                               insertableNotes[6]};
    return notes;
  }

  /** Generate array of expected notes this month based on insertable notes */
  private Note[] initializeNotesThisMonth(Note[] insertableNotes) {
    Note[] notes = new Note[] {insertableNotes[1],
                               insertableNotes[3],
                               insertableNotes[5],
                               insertableNotes[0],
                               insertableNotes[2],
                               insertableNotes[4],
                               insertableNotes[6]};
    return notes;
  }

  /** Generate array of expected notes all time based on insertable notes */
  private Note[] initializeNotesAllTime(Note[] insertableNotes) {
    Note[] notes = new Note[] {insertableNotes[1],
                               insertableNotes[3],
                               insertableNotes[5],
                               insertableNotes[0],
                               insertableNotes[2],
                               insertableNotes[4],
                               insertableNotes[6]};
    return notes;
  }

  /** Generate array of expected filtered notes all time based on insertable notes */
  private Note[] initializeNotesAllTimeFiltered(Note[] insertableNotes) {
    Note[] notes = new Note[] {insertableNotes[3],
                               insertableNotes[5],
                               insertableNotes[4],
                               insertableNotes[6]};
    return notes;
  }

  /** Generate array of expected notes favorited by the second new user based on insertable notes */
  private Note[] initializeNotesExpectedForSecondNewUser(Note[] insertableNotes) {
    Note[] notes = new Note[] {insertableNotes[1],
                               insertableNotes[3],
                               insertableNotes[5]};
    return notes;
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
                  NOTES_INSERTABLE[0].getId(),
                  NOTES_INSERTABLE[0].getAuthorId(),
                  NOTES_INSERTABLE[0].getSchool(),
                  NOTES_INSERTABLE[0].getCourse(),
                  NOTES_INSERTABLE[0].getTitle(),
                  NOTES_INSERTABLE[0].getSourceUrl(),
                  NOTES_INSERTABLE[0].getPdfSource(),
                  NOTES_INSERTABLE[0].getDateCreated(),
                  NOTES_INSERTABLE[0].getNumDownloads())
                .values(
                  NOTES_INSERTABLE[1].getId(),
                  NOTES_INSERTABLE[1].getAuthorId(),
                  NOTES_INSERTABLE[1].getSchool(),
                  NOTES_INSERTABLE[1].getCourse(),
                  NOTES_INSERTABLE[1].getTitle(),
                  NOTES_INSERTABLE[1].getSourceUrl(),
                  NOTES_INSERTABLE[1].getPdfSource(),
                  NOTES_INSERTABLE[1].getDateCreated(),
                  NOTES_INSERTABLE[1].getNumDownloads())
                .values(
                  NOTES_INSERTABLE[2].getId(),
                  NOTES_INSERTABLE[2].getAuthorId(),
                  NOTES_INSERTABLE[2].getSchool(),
                  NOTES_INSERTABLE[2].getCourse(),
                  NOTES_INSERTABLE[2].getTitle(),
                  NOTES_INSERTABLE[2].getSourceUrl(),
                  NOTES_INSERTABLE[2].getPdfSource(),
                  NOTES_INSERTABLE[2].getDateCreated(),
                  NOTES_INSERTABLE[2].getNumDownloads())
                .values(
                  NOTES_INSERTABLE[3].getId(),
                  NOTES_INSERTABLE[3].getAuthorId(),
                  NOTES_INSERTABLE[3].getSchool(),
                  NOTES_INSERTABLE[3].getCourse(),
                  NOTES_INSERTABLE[3].getTitle(),
                  NOTES_INSERTABLE[3].getSourceUrl(),
                  NOTES_INSERTABLE[3].getPdfSource(),
                  NOTES_INSERTABLE[3].getDateCreated(),
                  NOTES_INSERTABLE[3].getNumDownloads())
                .values(
                  NOTES_INSERTABLE[4].getId(),
                  NOTES_INSERTABLE[4].getAuthorId(),
                  NOTES_INSERTABLE[4].getSchool(),
                  NOTES_INSERTABLE[4].getCourse(),
                  NOTES_INSERTABLE[4].getTitle(),
                  NOTES_INSERTABLE[4].getSourceUrl(),
                  NOTES_INSERTABLE[4].getPdfSource(),
                  NOTES_INSERTABLE[4].getDateCreated(),
                  NOTES_INSERTABLE[4].getNumDownloads())
                .values(
                  NOTES_INSERTABLE[5].getId(),
                  NOTES_INSERTABLE[5].getAuthorId(),
                  NOTES_INSERTABLE[5].getSchool(),
                  NOTES_INSERTABLE[5].getCourse(),
                  NOTES_INSERTABLE[5].getTitle(),
                  NOTES_INSERTABLE[5].getSourceUrl(),
                  NOTES_INSERTABLE[5].getPdfSource(),
                  NOTES_INSERTABLE[5].getDateCreated(),
                  NOTES_INSERTABLE[5].getNumDownloads())
                .values(
                  NOTES_INSERTABLE[6].getId(),
                  NOTES_INSERTABLE[6].getAuthorId(),
                  NOTES_INSERTABLE[6].getSchool(),
                  NOTES_INSERTABLE[6].getCourse(),
                  NOTES_INSERTABLE[6].getTitle(),
                  NOTES_INSERTABLE[6].getSourceUrl(),
                  NOTES_INSERTABLE[6].getPdfSource(),
                  NOTES_INSERTABLE[6].getDateCreated(),
                  NOTES_INSERTABLE[6].getNumDownloads())
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
