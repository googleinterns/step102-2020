package com.google.starfish.services;

import static com.ninja_squad.dbsetup.Operations.*;
import com.ninja_squad.dbsetup.operation.Operation;
import java.util.Date;
import java.util.Calendar;

public class CommonOperations {
  private static Constants constants = new Constants();
  // Order matters when deleting from tables
  public static final Operation DELETE_ALL =
    deleteAllFrom(constants.FAVORITE_NOTES, constants.MISC_LABELS, constants.NOTES, constants.USERS, constants.LABELS);

  // Before every test, we will insert one user and their school as a label to serve as a reference
  public static final Operation INSERT_REFERENCE_DATA =
    sequenceOf(
        insertInto(constants.LABELS)
            .columns("title", "type")
            .values(constants.REFERENCE_SCHOOL, "School")
            .build(),
        insertInto(constants.LABELS)
            .columns("title", "type")
            .values(constants.REFERENCE_COURSE, "Course")
            .build(),
        insertInto(constants.USERS)
            .columns(
              "id", 
              "display_picture",
              "display_name",
              "date_joined",
              "email",
              "points",
              "school")
            .values(
              constants.REFERENCE_USER_ID,
              "test.url",
              "Aradhya",
              new Date(Calendar.getInstance().getTimeInMillis()),
              "thisisntmyrealemail@gmail.com",
              0,
              constants.REFERENCE_SCHOOL)
            .build());
}
