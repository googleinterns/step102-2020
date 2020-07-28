package com.google.starfish.servlets;

import javax.servlet.http.HttpSession;  
import javax.servlet.http.Cookie;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;

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
}