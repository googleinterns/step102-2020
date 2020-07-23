package com.google.starfish.servlets;  

import java.io.IOException;  
import java.sql.Connection;  
import java.sql.SQLException;  
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;  
import javax.servlet.annotation.WebServlet;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpSession;  
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.sql.DataSource;
import java.util.Date;
import com.google.starfish.services.FavoriteNoteService;
import com.google.starfish.services.NoteService;
import com.google.starfish.models.Note;
import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.List;

/** Servlet that either adds or removes a row from the favorite notes table */
@WebServlet("/favorite-note")  
public class FavoriteNoteServlet extends HttpServlet {  

  private NoteService noteService = new NoteService();
  private FavoriteNoteService favoriteNoteService = new FavoriteNoteService();
  private UserService userService = new UserService();
  private final String COOKIE_NAME = "SFCookie";

  @Override
  public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    if(!validateUser(req)) {
      res.setStatus(HttpServletResponse.SC_FORBIDDEN);
      return;
    }

    HttpSession activeSession = req.getSession(false);
    String userId = (String) activeSession.getAttribute("user_id");
    Long noteId = Long.valueOf(req.getParameter("note_id"));
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");  

    try (Connection conn = pool.getConnection()) {
      favoriteNoteService.insertFavoriteNote(pool, noteId, userId);
      Note downloadedNote = noteService.getNoteByNoteId(pool, noteId);
      String authorId = downloadedNote.getAuthorId();
      userService.increasePointsOnFavorite(pool, authorId);
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
    Long noteId = Long.valueOf(req.getParameter("note_id"));
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");  

    try (Connection conn = pool.getConnection()) {
      favoriteNoteService.deleteRowByCompoundId(pool, noteId, userId);
      Note downloadedNote = noteService.getNoteByNoteId(pool, noteId);
      String authorId = downloadedNote.getAuthorId();
      // TODO: After UserService is created, decrement the prestige points of user who posted noteId
    } catch (SQLException ex) {
      System.err.print(ex);
    }
  }

  /**
   * Validates the user using the request's session and cookies. If there is a
   * valid user logged in, returns true. Otherwise, returns false.
   **/
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