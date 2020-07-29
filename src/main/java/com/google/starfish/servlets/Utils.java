package com.google.starfish.servlets;

import com.google.gson.Gson;
import com.google.starfish.services.FavoriteNoteService.Recency;
import com.google.starfish.models.User;
import java.util.HashMap;

public class Utils {

  /** Converts a 2D Object array to JSON */
  public static String convert2DArrayToJSON(Object[][] arr) {
    Gson gson = new Gson();
    return gson.toJson(arr);
  }

  /** Converts a String array to JSON */
  public static String convertArrayToJSON(String[] array) {
    Gson gson = new Gson();
    return gson.toJson(array);
  }

  /** Converts a hash map to JSON */
  public static String convertHashMapToJSON(HashMap<String, String[]> hashMap) {
    Gson gson = new Gson();
    return gson.toJson(hashMap);
  }

  /** Converts an object to JSON */
  public static String convertObjectToJSON(User user) {
    Gson gson = new Gson();
    return gson.toJson(user);
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
