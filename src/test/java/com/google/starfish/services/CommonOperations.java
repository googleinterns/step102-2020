package com.google.starfish.services;

import static com.ninja_squad.dbsetup.Operations.*;
import com.ninja_squad.dbsetup.operation.Operation;
import java.util.Date;
import java.util.Calendar;

public class CommonOperations {
  // Order matters when deleting from tables
  public static final Operation DELETE_ALL =
    deleteAllFrom(Constants.FAVORITE_NOTES, Constants.MISC_LABELS, Constants.NOTES, Constants.USERS, Constants.LABELS);

  // Before every test, we will insert one user and their school as a label to serve as a reference
  public static final Operation INSERT_REFERENCE_DATA =
    sequenceOf(
        insertInto(Constants.LABELS)
            .columns("title", "type")
            .values(Constants.REFERENCE_SCHOOL, "School")
            .build(),
        insertInto(Constants.LABELS)
            .columns("title", "type")
            .values(Constants.REFERENCE_COURSE, "Course")
            .build(),
        insertInto(Constants.USERS)
            .columns(
              "id", 
              "display_picture",
              "display_name",
              "date_joined",
              "email",
              "points",
              "school")
            .values(
              Constants.REFERENCE_USER_ID,
              "test.url",
              "Aradhya",
              new Date(Calendar.getInstance().getTimeInMillis()),
              "thisisntmyrealemail@gmail.com",
              0,
              Constants.REFERENCE_SCHOOL)
            .build());
}
