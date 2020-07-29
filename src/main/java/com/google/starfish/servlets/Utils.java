package com.google.starfish.servlets;

import com.google.gson.Gson;
import com.google.starfish.services.FavoriteNoteService.Recency;

public class Utils {

  /** Converts a 2D array to JSON */
  public static String convert2DArrayToJSON(Object[][] arr) {
    Gson gson = new Gson();
    return gson.toJson(arr);
  }

  /** Finds key of Recency enum by string value */
  public static Recency findRecencyByString(String recency) {
    for (Recency r : Recency.values()) {
      if (r.getRecency().equals(recency)) {
        return r;
      }
    }
    return null;
  }

  /** If a string is not null, trims whitespace and makes it all lower case */
  public static String trimAndLowerCaseString(String string) {
    if (string == null || string.isEmpty()) return null;
    return string.toLowerCase().trim();
  }
}
