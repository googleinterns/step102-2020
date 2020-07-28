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
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.sql.DataSource;
import java.util.Date;
import com.google.starfish.services.FavoriteNoteService;
import com.google.starfish.services.NoteService;
import com.google.starfish.services.UserService;
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

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
    res.setContentType("application/json");
    if(!Utils.validateUser(req)) {
      res.getWriter().println(false);
      return;
    }
    HttpSession activeSession = req.getSession(false);
    String userId = (String) activeSession.getAttribute("user_id");
    Long noteId = Long.valueOf(req.getParameter("note_id"));
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");

    try(Connection conn = pool.getConnection()) {
      String stmt =
          "SELECT EXISTS "
        + "(SELECT * "
        + "FROM favorite_notes "
        + "WHERE user_id=? "
        + "AND note_id=?);";

      try (PreparedStatement favStmt = conn.prepareStatement(stmt)) {
        favStmt.setString(1, userId);
        favStmt.setLong(2, noteId);
        ResultSet rs = favStmt.executeQuery();
        rs.next();
        res.getWriter().println(rs.getBoolean(1));
      }
    } catch (SQLException ex) {
      System.err.print(ex);
    }
  }

  @Override
  public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    if(!Utils.validateUser(req)) {
      res.setStatus(HttpServletResponse.SC_FORBIDDEN);
      return;
    }

    HttpSession activeSession = req.getSession(false);
    String userId = (String) activeSession.getAttribute("user_id");
    Long noteId = Long.valueOf(req.getParameter("note_id"));
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");  

    try (Connection conn = pool.getConnection()) {
      favoriteNoteService.insertFavoriteNote(pool, noteId, userId);
      String authorId = noteService.getNoteByNoteId(pool, noteId).getAuthorId();
      userService.increasePointsOnFavorite(pool, authorId);
    } catch (SQLException ex) {
      System.err.print(ex);
    }
  }

  @Override
  public void doDelete(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    if(!Utils.validateUser(req)) {
      res.setStatus(HttpServletResponse.SC_FORBIDDEN);
      return;
    }

    HttpSession activeSession = req.getSession(false);
    String userId = (String) activeSession.getAttribute("user_id");
    Long noteId = Long.valueOf(req.getParameter("note_id"));
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");

    try (Connection conn = pool.getConnection()) {
      favoriteNoteService.deleteRowByCompoundId(pool, noteId, userId);
      String authorId = noteService.getNoteByNoteId(pool, noteId).getAuthorId();
      userService.decreasePointsOnUnfavorite(pool, authorId);
    } catch (SQLException ex) {
      System.err.print(ex);
    }
  }
}