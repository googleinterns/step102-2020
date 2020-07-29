package com.google.starfish.servlets;

import javax.servlet.http.HttpSession;  
import javax.servlet.http.Cookie;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.google.starfish.services.FavoriteNoteService.Recency;

public class Utils {

  private static final String COOKIE_NAME = "SFCookie";

  /**
   * Validates the user using the request's session and cookies. If there is a
   * valid user logged in, returns true. Otherwise, returns false.
   **/
  public static boolean validateUser(HttpServletRequest req) {
    Cookie[] cookies = req.getCookies();
    String sessionId = null;
    for (Cookie cookie : cookies) {
      if (COOKIE_NAME.equals(cookie.getName())) {
        sessionId = cookie.getValue();
        break;
      }
    }

    // If there was no cookie passed, then auth has failed and user is not logged in
    if(sessionId == null) {
      return false;
    }

    HttpSession activeSession = req.getSession(false);
    if (activeSession == null || activeSession.getAttribute("user_id") == null) {
      return false;
    }
    return true;
  }

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
