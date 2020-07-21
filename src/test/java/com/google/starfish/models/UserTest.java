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
                   .setId(1)
                   .setEmail("usertester@test.com")
                   .setPoints(0)
                   .build();
    Assert.assertNotNull(user);
  }

  @Test
  public void constructorTestWithRequiredAndOptionalParams() {
    user = new User.Builder()
                   .setId(1)
                   .setEmail("usertester@test.com")
                   .setPoints(0)
                   .setDateJoined(Calendar.getInstance().getTime())
                   .setOptionalSchool("Western University")
                   .setOptionalDisplayProperties("https://testurl.com", "Xkid321")
                   .setOptionalFavoriteNotes(new long[] {1, 2, 3, 4})
                   .setOptionalUploadedNotes(new long[] {1, 2, 3, 4})
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
