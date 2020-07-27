package com.google.starfish.services;

import com.google.starfish.models.Note;
import java.util.Date;
import java.sql.SQLException;
import java.util.Calendar;
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
public final class NoteServiceTest {

  private Constants constants = new Constants();
  private DataSource pool = Constants.pool;
  private String NOTES = constants.NOTES;
  private NoteService noteService = new NoteService();

  @Before
  public void prepare() throws Exception {
    Operation operation =
        sequenceOf(
            CommonOperations.DELETE_ALL,
            CommonOperations.INSERT_REFERENCE_DATA,
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
                .build());
    DbSetup dbSetup = new DbSetup(new DataSourceDestination(pool), operation);
    dbSetup.launch();
  }

  @Test
  public void testGettingUploadedNotesByUserId() throws SQLException {
    Note[] uploadedNotes = noteService.getUploadedNotesByUserId(pool, constants.REFERENCE_USER_ID);
    assertEquals(uploadedNotes.length, 3);
  }

  @Test
  public void testIncrementingDownloadsByNoteId() throws SQLException {
    Note noteBeforeOperation = noteService.getNoteByNoteId(pool, 1);
    long numDownloadsBeforeOperation = noteBeforeOperation.getNumDownloads();

    noteService.incrementDownloadsByNoteId(pool, 1);

    Note noteAfterOperation = noteService.getNoteByNoteId(pool, 1);
    long numDownloadsAfterOperation = noteAfterOperation.getNumDownloads();

    assertEquals(numDownloadsBeforeOperation + 1, numDownloadsAfterOperation);
  }
}
