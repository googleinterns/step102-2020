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
import java.util.List;

/** Servlet that returns search results for notes based on school and course */
@WebServlet("/search")  
public class SearchServlet extends HttpServlet {  

  private NoteService noteService = new NoteService();

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");  

    String reqSchool = trimAndLowerCaseString(req.getParameter("school"));
    String reqCourse = trimAndLowerCaseString(req.getParameter("course"));

    try (Connection conn = pool.getConnection()) {
      try {
        conn.setAutoCommit(false);
        String stmt = getSearchQuery(reqSchool, reqCourse);
        try (PreparedStatement getNotesStatement = conn.prepareStatement(stmt)) {
          getNotesStatement.setString(1, reqSchool);
          getNotesStatement.setString(2, reqCourse);
          ResultSet rs = getNotesStatement.executeQuery();
          conn.commit();

          List<Note> notes = createNotesFromResultOfSeach(pool, rs);
          String json = convertListToJson(notes);
          res.setContentType("application/json");
          res.getWriter().println(json);
        } 
      } catch (SQLException ex) {
          if (conn != null) {
            try {
              System.err.print("Transaction is being rolled back.");
              conn.rollback();
            } catch (SQLException excep) {
              System.err.print(excep);
            }
          }
        }
      } catch (SQLException ex) {
        System.err.print(ex);
      }
    }

  /** Dynamically generates sql query statement for note search */
  private String getSearchQuery(String school, String course) {
    String stmt = 
        "SELECT * "
      + "FROM `starfish.notes` "
      + "WHERE 1=1";
    if (school != null && !school.isEmpty()) {
      stmt += " AND `school`= ?";
    }
    if (course != null && !course.isEmpty()) {
      stmt += " AND `course`= ?";
    }
    stmt += ";";
    return stmt;
  }

  /** Creates a list of note objects based on the result set of a search query in the DB */
  private List<Note> createNotesFromResultOfSeach(DataSource pool, ResultSet rs) throws SQLException {
    List<Note> notes = new ArrayList<>();
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
    return notes;
  }

  /** If a string is not null, trims whitespace and makes it all lower case */
  private String trimAndLowerCaseString(String string) {
    if (string == null || string.isEmpty()) return null;
    return string.toLowerCase().trim();
  }

  /** Converts an array list to JSON */
  private String convertListToJson(List<Note> notes) {
    Gson gson = new Gson();
    return gson.toJson(notes);
  }
}  
