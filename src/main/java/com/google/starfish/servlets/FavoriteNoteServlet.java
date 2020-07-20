package com.google.starfish.servlets;  

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import java.io.IOException;  
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
import com.google.starfish.services.FavoriteNoteService;

/** Servlet that handles user registration and authentication. */  
@WebServlet("/favorite-note")  
public class FavoriteNoteServlet extends HttpServlet {

  private static final Logger LOGGER = Logger.getLogger(FavoriteNoteServlet.class.getName());
  private static final String CLIENT_ID = System.getenv("CLIENT_ID");
  private final String COOKIE_NAME = "SFCookie";
  private FavoriteNoteService favoriteNoteService = new FavoriteNoteService();

  @Override 
  public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    if(!validateUser(req)) {
      res.setStatus(HttpServletResponse.SC_FORBIDDEN);
      return;
    }

    HttpSession activeSession = req.getSession(false);
    String userId = (String) activeSession.getAttribute("user_id");
    long noteId = Long.valueOf(req.getParameter("note_id"));
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");

    try (Connection conn = pool.getConnection()) {
      favoriteNoteService.insertFavoriteNote(pool, noteId, userId);
    } catch (SQLException ex) {
      System.err.print(ex);
    }
  }

  @Override 
  public void doDelete(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    if(!validateUser(req)) {
      res.setStatus(HttpServletResponse.SC_FORBIDDEN);
      return;
    }

    HttpSession activeSession = req.getSession(false);
    String userId = (String) activeSession.getAttribute("user_id");
    long noteId = Long.valueOf(req.getParameter("note_id"));
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");

    try (Connection conn = pool.getConnection()) {
      favoriteNoteService.deleteRowByCompoundId(pool, noteId, userId);
    } catch (SQLException ex) {
      System.err.print(ex);
    }   
  }

  private boolean validateUser(HttpServletRequest req) {
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