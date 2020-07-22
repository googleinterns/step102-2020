package com.google.starfish.servlets;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;  
import javax.servlet.http.Cookie;  
import com.google.starfish.services.LabelService;
import com.google.starfish.services.MiscNoteLabelService;
import javax.sql.DataSource;
import java.sql.Connection;  
import java.sql.SQLException;  
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.util.Calendar;

/** Servlet to handle note uploading and adding associated labels to the database */
@WebServlet("/upload-gnote")
public class UploadGNoteServlet extends HttpServlet {

  private final String COOKIE_NAME = "SFCookie";
  private LabelService labelService = new LabelService();
  
  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    if(!validateUser(request)) {
      response.setStatus(HttpServletResponse.SC_FORBIDDEN);
      return;
    }

    HttpSession activeSession = request.getSession(false);
    String userId = (String) activeSession.getAttribute("user_id");

    String title = request.getParameter("title");
    String school = request.getParameter("school").toLowerCase();
    String course = request.getParameter("course").toLowerCase();
    // String[] miscLabels = request.getParameterValues("miscLabels");
    String sourceUrl = request.getParameter("sourceUrl");
    String pdfSource = request.getParameter("pdfSource");
    System.out.println(title);
    System.out.println(school);
    System.out.println(course);
    System.out.println(sourceUrl);
    System.out.println(pdfSource);

    DataSource pool = (DataSource) request.getServletContext().getAttribute("my-pool");

    // Insert all labels before inserting note due to foreign key constraint
    labelService.insertSchoolLabel(pool, school);
    labelService.insertCourseLabel(pool, course);
    // for (String miscLabel : miscLabels) {
    //   labelService.insertMiscLabel(pool, miscLabel.toLowerCase());
    // }
    
    try (Connection conn = pool.getConnection()) {
      String stmt =
          "INSERT INTO notes ( "
              + "author_id,"
              + "school,"
              + "course,"
              + "title,"
              + "source_url,"
              + "pdf_source,"
              + "date_created,"
              + "num_downloads ) "
        + "VALUES ( "
              + "?,"
              + "?,"
              + "?,"
              + "?,"
              + "?,"
              + "?,"
              + "?,"
              + "? ); ";

      try (PreparedStatement noteStmt = conn.prepareStatement(stmt, new String[] {"id"})) {
        noteStmt.setString(1, userId);
        noteStmt.setString(2, school);
        noteStmt.setString(3, course);
        noteStmt.setString(4, title);
        noteStmt.setString(5, sourceUrl);
        noteStmt.setString(6, pdfSource);
        noteStmt.setDate(7, new Date(Calendar.getInstance().getTimeInMillis()));
        noteStmt.setLong(8, 0); // num_downloads
        int rowsAffected = noteStmt.executeUpdate();
        if (rowsAffected == 1) {
          long noteId = 0;
          ResultSet rs = noteStmt.getGeneratedKeys();
          // if (rs.next()) {
          //   noteId = rs.getLong(1);
          //   // Associate misc labels to the newly added note
          //   for (String miscLabel : miscLabels) {
          //     miscNoteLabelService.insertMiscNoteLabel(pool, noteId, miscLabel);
          //   }
          // } 
        }
      }
    } catch (SQLException ex) {
      response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
      response.getWriter().println("INTERNAL SERVER ERROR: " + ex);
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