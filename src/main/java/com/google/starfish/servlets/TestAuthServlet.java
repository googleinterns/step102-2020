package com.google.starfish.servlets;  

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import java.io.IOException;  
import java.io.PrintWriter;  
import java.sql.Connection;  
import java.sql.SQLException;  
import java.sql.PreparedStatement;
import java.sql.Types;  
import java.sql.ResultSet;
import java.sql.Date;
import javax.servlet.ServletException;  
import java.security.GeneralSecurityException;
import javax.servlet.annotation.WebServlet;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpSession;  
import javax.servlet.http.Cookie;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.sql.DataSource;
import java.util.Calendar;
import java.util.Collections;
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
    if(sessionId == null) {
      res.setStatus(418);
      return;
    }

    System.out.println(sessionId);

    HttpSession activeSession = req.getSession(false);
    if (activeSession == null || activeSession.getAttribute("user_id") == null) {
      LOGGER.log(Level.WARNING, "No user is logged in.");
      // Set an error code of 403 if the user is not logged in
      res.setStatus(HttpServletResponse.SC_FORBIDDEN);
      return;
    }
    res.setStatus(HttpServletResponse.SC_OK);
  }
}
