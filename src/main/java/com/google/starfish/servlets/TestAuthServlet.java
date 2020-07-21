package com.google.starfish.servlets;  

import java.io.IOException;  
import javax.servlet.ServletException;  
import javax.servlet.annotation.WebServlet;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpSession;  
import javax.servlet.http.Cookie;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import java.util.logging.Level;
import java.util.logging.Logger;

/** Servlet that handles user registration and authentication. */  
@WebServlet("/test-auth")  
public class TestAuthServlet extends HttpServlet {

  private static final Logger LOGGER = Logger.getLogger(UserLogoutServlet.class.getName());
  private final String COOKIE_NAME = "SFCookie";

  @Override 
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    Cookie[] cookies = req.getCookies();
    String sessionId = null;
    for (Cookie cookie : cookies) {
      if (COOKIE_NAME.equals(cookie.getName())) {
        sessionId = cookie.getValue();
      }
    }
    // If there was no cookie passed with request to /test-auth, then auth has failed and user is not logged in
    if(sessionId == null) {
      res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
      return;
    }

    HttpSession activeSession = req.getSession(false);
    if (activeSession == null || activeSession.getAttribute("user_id") == null) {
      LOGGER.log(Level.WARNING, "No user is logged in.");
      // Set an error code of 403 if the user is not logged in
      res.setStatus(HttpServletResponse.SC_FORBIDDEN);
      return;
    }

    // If this user has an active session, then the user is logged in
    res.setStatus(HttpServletResponse.SC_OK);
  }
}
