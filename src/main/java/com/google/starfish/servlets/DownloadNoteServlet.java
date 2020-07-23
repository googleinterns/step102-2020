package com.google.starfish.servlets;  

import java.io.IOException;  
import java.sql.Connection;  
import java.sql.SQLException;  
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;  
import javax.servlet.annotation.WebServlet;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.sql.DataSource;
import com.google.starfish.services.NoteService;
import com.google.starfish.services.UserService;
import com.google.starfish.models.Note;

/** Servlet that increments the number of downloads on a note. */
@WebServlet("/download-note")  
public class DownloadNoteServlet extends HttpServlet {  

  private NoteService noteService = new NoteService();
  private UserService userService = new UserService();

  @Override
  public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    Long noteId = Long.valueOf(req.getParameter("note_id"));
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");  

    try (Connection conn = pool.getConnection()) {
      noteService.incrementDownloadsByNoteId(pool, noteId);
      Note downloadedNote = noteService.getNoteByNoteId(pool, noteId);
      String userId = downloadedNote.getAuthorId();
      userService.increasePointsOnDownload(pool, userId);
    } catch (SQLException ex) {
      System.err.print(ex);
    }
  }
} 