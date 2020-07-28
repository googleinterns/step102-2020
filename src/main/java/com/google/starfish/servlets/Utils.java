package com.google.starfish.servlets;

import com.google.gson.Gson;

public class Utils {

  /** Converts a 2D array to JSON */
  public static String convert2DArrayToJSON(Object[][] arr) {
    Gson gson = new Gson();
    return gson.toJson(arr);
  }
}
