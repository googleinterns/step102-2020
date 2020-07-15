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
import java.util.Date;
import com.google.starfish.services.NoteService;
import com.google.starfish.models.Note;
import com.google.gson.Gson;
import java.util.ArrayList;

/** Servlet that returns search results for notes based on school and course */
@WebServlet("/search")  
public class SearchServlet extends HttpServlet {  

  private NoteService noteService = new NoteService();

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");  
    String reqSchool = req.getParameter("school").toLowerCase();
    String reqCourse= req.getParameter("course").toLowerCase();
    ArrayList<Note> notes = new ArrayList<>();
    try (Connection conn = pool.getConnection()) {
      String stmt = 
          "SELECT * "
        + "FROM `starfish.notes` "
        + "WHERE `school`= ? AND `course` = ?;";
      try (PreparedStatement getNotesStatement = conn.prepareStatement(stmt)) {
        getNotesStatement.setString(1, reqSchool);
        getNotesStatement.setString(2, reqCourse);
        ResultSet rs = getNotesStatement.executeQuery();

        while (rs.next()) {
          long noteId = rs.getLong("id");
          long authorId = rs.getLong("author_id");
          String school = rs.getString("school");
          String course = rs.getString("course");
          String title = rs.getString("title");
          String sourceUrl = rs.getString("title");
          String pdfSource = rs.getString("pdf_source");
          Date dateCreated = rs.getDate("date_created");
          long numDownloads = rs.getLong("num_downloads");
          long numFavorites = noteService.getNumFavoritesById(pool, noteId);

          Note thisNote = new Note.Builder()
                              .setId(noteId)
                              .setAuthorId(authorId)
                              .setRequiredLabels(school, course)
                              .setNoteTitle(title)
                              .setSourceUrl(sourceUrl)
                              .setOptionalPdfSource(pdfSource)
                              .setDateCreated(dateCreated)
                              .setNumDownloads(numDownloads)
                              .setNumFavorites(numFavorites)
                              .build();
          notes.add(thisNote);
        }
        String json = convertArrayListToJson(notes);
        res.setContentType("application/json");
        res.getWriter().println(json);
      }
    } catch (SQLException ex) {
        res.getWriter().println("Error caught while speaking to database: " + ex);  
    }
  }  

  /** Converts an array list to JSON */
  private String convertArrayListToJson(ArrayList<Note> notes) {
    Gson gson = new Gson();
    return gson.toJson(notes);
  }
}  
