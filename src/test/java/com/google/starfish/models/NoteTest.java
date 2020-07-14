package com.google.starfish.models;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import java.util.Calendar;

@RunWith(JUnit4.class)
public final class NoteTest {

  private Note note;

  @Test
  public void constructorTestWithRequiredParams() {
    note = new Note.Builder()
                   .setId(1)
                   .setAuthorId(3)
                   .setNoteTitle("Test Note")
                   .setSourceUrl("https://test.com")
                   .setRequiredLabels("Western University", "SE2203")
                   .setDateCreated(Calendar.getInstance().getTime())
                   .setNumDownloads(156)
                   .setNumFavorites(143)
                   .build();
    Assert.assertNotNull(note);
  }

  @Test
  public void constructorTestWithRequiredAndOptionalParams() {
    note = new Note.Builder()
                   .setId(1)
                   .setAuthorId(3)
                   .setNoteTitle("Test Note")
                   .setSourceUrl("https://test.com")
                   .setRequiredLabels("Western University", "SE2203")
                   .setDateCreated(Calendar.getInstance().getTime())
                   .setNumDownloads(156)
                   .setNumDownloads(156)
                   .setNumFavorites(143)
                   .setOptionalPdfSource(("https://testsource.com"))
                   .setMiscLabels(new String[] {"AI", "ML", "NLP", "Physics"})
                   .build();
    Assert.assertNotNull(note);
  }

  @Test(expected = NullPointerException.class)
  public void contructorTestWithMissingRequiredParams() {
    note = new Note.Builder()
                   .setNoteTitle("Test Note")
                   .setSourceUrl("https://test.com")
                   .setRequiredLabels("Western University", "SE2203")
                   .setNumDownloads(156)
                   .setNumFavorites(143)
                   .build();
  }
}
