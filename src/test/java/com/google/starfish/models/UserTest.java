package com.google.starfish.models;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import java.util.Calendar;

@RunWith(JUnit4.class)
public final class UserTest {

  private User user;

  @Test
  public void constructorTestWithRequiredParams() {
    user = new User.Builder()
                   .setId("1")
                   .setEmail("usertester@test.com")
                   .setPoints(0)
                   .build();
    Assert.assertNotNull(user);
  }

  @Test
  public void constructorTestWithRequiredAndOptionalParams() {
    Note note = new Note.Builder()
                   .setId(1)
                   .setAuthorId("3")
                   .setNoteTitle("Test Note")
                   .setSourceUrl("https://test.com")
                   .setRequiredLabels("Western University", "SE2203")
                   .setDateCreated(Calendar.getInstance().getTime())
                   .setNumDownloads(156)
                   .setNumFavorites(143)
                   .build();

    user = new User.Builder()
                   .setId("1")
                   .setEmail("usertester@test.com")
                   .setPoints(0)
                   .setDateJoined(Calendar.getInstance().getTime())
                   .setOptionalSchool("Western University")
                   .setOptionalDisplayProperties("https://testurl.com", "Xkid321")
                   .setOptionalFavoriteNotes(new Note[] {note})
                   .setOptionalUploadedNotes(new Note[] {note})
                   .build();
    Assert.assertNotNull(user);
  }

  @Test(expected = NullPointerException.class)
  public void contructorTestWithMissingRequiredParams() {
    user = new User.Builder()
                   .setPoints(0)
                   .build();
  }
}
