package com.google.starfish.services;

import java.util.Date;
import java.util.Calendar;
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

  private final Date today = favoriteNoteService.getDateBasedOnRecency(Recency.TODAY);
  private final Date thisWeek = favoriteNoteService.getDateBasedOnRecency(Recency.THIS_WEEK);
  private final Date thisMonth = favoriteNoteService.getDateBasedOnRecency(Recency.THIS_MONTH);
  private final Date allTime = favoriteNoteService.getDateBasedOnRecency(Recency.ALL_TIME);

  private final String newSchool = "cornell university";
  private final String newCourse = "cs1300";
  private final String firstNewUserId = Integer.toString(Integer.parseInt(constants.REFERENCE_USER_ID) + 1);
  private final String secondNewUserId = Integer.toString(Integer.parseInt(constants.REFERENCE_USER_ID) + 2);

  private static final boolean runTests = Constants.TEST_DB_NAME.equals("starfish_test");

  /** Clear DB and insert reference data */
  @Before
  public void prepare() throws Exception {
    if(!runTests) throw new Exception("Wrong Test Database Name");
    Operation operation = getBeforeTestOperation();
    DbSetup dbSetup = new DbSetup(new DataSourceDestination(pool), operation);
    dbSetup.launch();
  }

  /** Test to see if we can get all notes favorited by a single user */
  @Test
  public void testGettingFavoriteNotesByUserId() throws SQLException {
    Note[] favoriteNotes = favoriteNoteService.getFavoriteNotesByUserId(pool, firstNewUserId);
    assertEquals(favoriteNotes.length, 7);
  }

  /** Test to see if we can get the number of times a particular note has been favorited */
  @Test
  public void testGettingNumFavoritesByNoteId() throws SQLException {
    long numFavoritesOfNoteOne = favoriteNoteService.getNumFavoritesByNoteId(pool, 1);
    long numFavoritesOfNoteTwo = favoriteNoteService.getNumFavoritesByNoteId(pool, 2);
    assertTrue(numFavoritesOfNoteOne == 1);
    assertTrue(numFavoritesOfNoteTwo == 2);
  }

  /** Test to see if we can correctly retrieve the most trending notes today */
  @Test
  public void testGettingTrendingNotesToday() throws SQLException, Exception {
    Object[][] trendingNotesToday = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, Recency.TODAY, null, null);
    // We should be getting all 7 notes irrespective of whether they are trending or not
    if (trendingNotesToday.length != 7) throw new Exception("Retrieved wrong number of notes: " + trendingNotesToday.length);
    int numTrendingNotes = 2;
    Note mostTrendingNote = (Note) trendingNotesToday[0][0];
    long numFavoritesMostTrendingNote = (long) trendingNotesToday[0][1];
    Note leastTrendingNote = (Note) trendingNotesToday[numTrendingNotes - 1][0];
    long numFavoritesLeastTrendingNote = (long) trendingNotesToday[numTrendingNotes - 1][1];
    long numFavoritesFirstNoteWithNoFavorite = (long) trendingNotesToday[numTrendingNotes][1];
    assertTrue(mostTrendingNote.getId() == 2);
    assertTrue(numFavoritesMostTrendingNote == 2);
    assertTrue(leastTrendingNote.getId() == 1);
    assertTrue(numFavoritesLeastTrendingNote == 1);
    assertTrue(numFavoritesFirstNoteWithNoFavorite == 0);
  }

  /** Test to see if we can correctly retrieve the most trending notes this week */
  @Test 
  public void testGettingTrendingNotesThisWeek() throws SQLException, Exception {
    Object[][] trendingNotesThisWeek = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, Recency.THIS_WEEK, null, null);
    // We should be getting all 7 notes irrespective of whether they are trending or not
    if (trendingNotesThisWeek.length != 7) throw new Exception("Retrieved wrong number of notes: " + trendingNotesThisWeek.length);
    int numTrendingNotes = 4;
    Note mostTrendingNote = (Note) trendingNotesThisWeek[0][0];
    long numFavoritesMostTrendingNote = (long) trendingNotesThisWeek[0][1];
    Note leastTrendingNote = (Note) trendingNotesThisWeek[numTrendingNotes - 1][0];
    long numFavoritesLeastTrendingNote = (long) trendingNotesThisWeek[numTrendingNotes - 1][1];
    long numFavoritesFirstNoteWithNoFavorite = (long) trendingNotesThisWeek[numTrendingNotes][1];
    assertTrue(mostTrendingNote.getId() == 4 || mostTrendingNote.getId() == 2);
    assertTrue(numFavoritesMostTrendingNote == 2);
    assertTrue(leastTrendingNote.getId() == 3 || leastTrendingNote.getId() == 1);
    assertTrue(numFavoritesLeastTrendingNote == 1);
    assertTrue(numFavoritesFirstNoteWithNoFavorite == 0);
  }

  /** Test to see if we can correctly retrieve the most trending notes this month */
  @Test
  public void testGettingTrendingNotesThisMonth() throws SQLException, Exception {
    Object[][] trendingNotesThisMonth = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, Recency.THIS_MONTH, null, null);
    // We should be getting all 7 notes irrespective of whether they are trending or not
    if (trendingNotesThisMonth.length != 7) throw new Exception("Retrieved wrong number of notes: " + trendingNotesThisMonth.length);
    int numTrendingNotes = 6;
    Note mostTrendingNote = (Note) trendingNotesThisMonth[0][0];
    long numFavoritesMostTrendingNote = (long) trendingNotesThisMonth[0][1];
    Note leastTrendingNote = (Note) trendingNotesThisMonth[numTrendingNotes - 1][0];
    long numFavoritesLeastTrendingNote = (long) trendingNotesThisMonth[numTrendingNotes - 1][1];
    long numFavoritesFirstNoteWithNoFavorite = (long) trendingNotesThisMonth[numTrendingNotes][1];
    assertTrue(mostTrendingNote.getId() == 6 ||  mostTrendingNote.getId() == 4 || mostTrendingNote.getId() == 2);
    assertTrue(numFavoritesMostTrendingNote == 2);
    assertTrue(leastTrendingNote.getId() == 5 || leastTrendingNote.getId() == 3 || leastTrendingNote.getId() == 1);
    assertTrue(numFavoritesLeastTrendingNote == 1);
    assertTrue(numFavoritesFirstNoteWithNoFavorite == 0);
  }

  /** Test to see if we can correctly retrieve the most trending notes all time */
  @Test
  public void testGettingTrendingNotesAllTime() throws SQLException, Exception {
    Object[][] trendingNotesAllTime = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, Recency.ALL_TIME, null, null);
    // We should be getting all 7 notes irrespective of whether they are trending or not
    if (trendingNotesAllTime.length != 7) throw new Exception("Retrieved wrong number of notes: " + trendingNotesAllTime.length);
    int numTrendingNotes = 7;
    Note mostTrendingNote = (Note) trendingNotesAllTime[0][0];
    long numFavoritesMostTrendingNote = (long) trendingNotesAllTime[0][1];
    Note leastTrendingNote = (Note) trendingNotesAllTime[numTrendingNotes - 1][0];
    long numFavoritesLeastTrendingNote = (long) trendingNotesAllTime[numTrendingNotes - 1][1];
    // There is no note with 0 favorites all time, so we don't check for the first note with no favorite
    assertTrue(mostTrendingNote.getId() == 6 ||  
               mostTrendingNote.getId() == 4 || 
               mostTrendingNote.getId() == 2);
    assertTrue(numFavoritesMostTrendingNote == 2);
    assertTrue(leastTrendingNote.getId() == 7 || 
               leastTrendingNote.getId() == 5 || 
               leastTrendingNote.getId() == 3 || 
               leastTrendingNote.getId() == 1);
    assertTrue(numFavoritesLeastTrendingNote == 1);
  }

  /** Test to see if we can correctly retrieve the most trending notes all time filtered by school and course */
  @Test
  public void testGettingTrendingNotesAllTimeFilteredBySchoolAndCourse() throws SQLException, Exception {
    Object[][] trendingNotesAllTime = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, 
                                                                                           Recency.ALL_TIME, 
                                                                                           newSchool, 
                                                                                           newCourse);
    if (trendingNotesAllTime.length != 4) throw new Exception("Retrieved wrong number of notes: " + trendingNotesAllTime.length);
    Note mostTrendingNote = (Note) trendingNotesAllTime[0][0];
    long numFavoritesMostTrendingNote = (long) trendingNotesAllTime[0][1];
    Note leastTrendingNote = (Note) trendingNotesAllTime[3][0];
    long numFavoritesLeastTrendingNote = (long) trendingNotesAllTime[3][1];
    assertTrue(mostTrendingNote.getId() == 6 ||  mostTrendingNote.getId() == 4);
    assertTrue(numFavoritesMostTrendingNote == 2);
    assertTrue(leastTrendingNote.getId() == 7 || leastTrendingNote.getId() == 5);
    assertTrue(numFavoritesLeastTrendingNote == 1);
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
                  firstNewUserId,
                  "test.url",
                  "Aradhya",
                  new Date(Calendar.getInstance().getTimeInMillis()),
                  "thisisntmyrealemail@gmail.com",
                  0,
                  constants.REFERENCE_SCHOOL)
                .values(
                  secondNewUserId,
                  "test.url",
                  "Aradhya",
                  new Date(Calendar.getInstance().getTimeInMillis()),
                  "thisisntmyrealemail@gmail.com",
                  0,
                  constants.REFERENCE_SCHOOL)
                .build(),
            insertInto(LABELS)
                .columns("title", "type")
                .values(newSchool, "School")
                .values(newCourse, "Course")
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
                  today,
                  0)
                .values(
                  2,
                  constants.REFERENCE_USER_ID,
                  constants.REFERENCE_SCHOOL,
                  constants.REFERENCE_COURSE,
                  "The Second Best Notes Ever",
                  "test.url",
                  "pdftest.url",
                  today,
                  0)
                .values(
                  3,
                  constants.REFERENCE_USER_ID,
                  constants.REFERENCE_SCHOOL,
                  constants.REFERENCE_COURSE,
                  "The Third Best Notes Ever",
                  "test.url",
                  "pdftest.url",
                  thisWeek,
                  0)
                .values(
                  4,
                  constants.REFERENCE_USER_ID,
                  newSchool,
                  newCourse,
                  "The Fourth Best Notes Ever",
                  "test.url",
                  "pdftest.url",
                  thisWeek,
                  0)
                .values(
                  5,
                  constants.REFERENCE_USER_ID,
                  newSchool,
                  newCourse,
                  "The Fifth Best Notes Ever",
                  "test.url",
                  "pdftest.url",
                  thisMonth,
                  0)
                .values(
                  6,
                  constants.REFERENCE_USER_ID,
                  newSchool,
                  newCourse,
                  "The Sixth Best Notes Ever",
                  "test.url",
                  "pdftest.url",
                  thisMonth,
                  0)
                .values(
                  7,
                  constants.REFERENCE_USER_ID,
                  newSchool,
                  newCourse,
                  "The Seventh Best Notes Ever",
                  "test.url",
                  "pdftest.url",
                  allTime,
                  0)
                .build(),
            insertInto(FAVORITE_NOTES)
                .columns("user_id", "note_id", "date")
                .values(firstNewUserId, 1, today)
                .values(firstNewUserId, 2, today)
                .values(firstNewUserId, 3, thisWeek)
                .values(firstNewUserId, 4, thisWeek)
                .values(firstNewUserId, 5, thisMonth)
                .values(firstNewUserId, 6, thisMonth)
                .values(firstNewUserId, 7, allTime)
                .values(secondNewUserId, 2, today)
                .values(secondNewUserId, 4, thisWeek)
                .values(secondNewUserId, 6, thisMonth)
                .build());
    return operation;
  }
}
