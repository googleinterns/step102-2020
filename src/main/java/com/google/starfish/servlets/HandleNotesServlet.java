package com.google.starfish.servlets;

import com.google.appengine.api.blobstore.BlobInfo;
import com.google.appengine.api.blobstore.BlobInfoFactory;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
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


@WebServlet("/handle-notes")
public class HandleNotesServlet extends HttpServlet {

  private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
  private final String COOKIE_NAME = "SFCookie";
  private LabelService labelService = new LabelService();
  private MiscNoteLabelService miscNoteLabelService = new MiscNoteLabelService();
  
  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    if(!validateUser(request)) {
      response.setStatus(HttpServletResponse.SC_FORBIDDEN);
      return;
    }

    HttpSession activeSession = request.getSession(false);
    String userId = (String) activeSession.getAttribute("user_id");
    String blobKey = getUploadedFileBlobKey(request, "file");
    String sourceUrl = request.getParameter("sourceUrl");

    // There must be some source, either a blob or url, for this note to be posted
    if (blobKey == null && sourceUrl == null) {
      response.setStatus(HttpServletResponse.SC_NOT_ACCEPTABLE);
      return;
    }

    String title = request.getParameter("title");
    String school = request.getParameter("school").toLowerCase();
    String course = request.getParameter("course").toLowerCase();
    String[] miscLabels = request.getParameter("miscLabels").split(",");

    DataSource pool = (DataSource) request.getServletContext().getAttribute("my-pool");

    // Insert all labels before inserting note due to foreign key constraint
    labelService.insertSchoolLabel(pool, school);
    labelService.insertCourseLabel(pool, course);
    for (String miscLabel : miscLabels) {
      labelService.insertMiscLabel(pool, miscLabel.toLowerCase());
    }
    
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
        if (sourceUrl == null) {
          // If there was no sourceUrl, this is an uploaded pdf so
          // set the sourceUrl to be the same as the pdfSource
          noteStmt.setString(5, blobKey);
        } else {
          // If there is a sourceUrl on the request param, this is
          // a google doc set set the source url based on the passed param
          noteStmt.setString(5, sourceUrl);
        }
        // The blob key is nullable on the notes table so if this is a google doc
        // this will be null
        noteStmt.setString(6, blobKey);
        noteStmt.setDate(7, new Date(Calendar.getInstance().getTimeInMillis()));
        noteStmt.setLong(8, 0);
        int rowsAffected = noteStmt.executeUpdate();
        if (rowsAffected == 1) {
          long noteId = 0;
          ResultSet rs = noteStmt.getGeneratedKeys();
          if (rs.next()) {
            noteId = rs.getLong(1);
            // Associate misc labels to the newly added note
            for (String miscLabel : miscLabels) {
              miscNoteLabelService.insertMiscNoteLabel(pool, noteId, miscLabel);
            }
          } 
        }
      }
    } catch (SQLException ex) {
      response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
      response.getWriter().println("INTERNAL SERVER ERROR: " + ex);
    }    
    response.sendRedirect("/");
  }

  /** Returns a blob key for the uploaded file, or null if the user didn't upload a file. */
  private String getUploadedFileBlobKey(HttpServletRequest request, String formInputElementName) {
    Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(request);
    List<BlobKey> blobKeys = blobs.get(formInputElementName);

    // User submitted form without selecting a file, so we can't get a URL
    if (blobKeys == null || blobKeys.isEmpty()) {
      return null;
    }

    // Form only contains a single file input, so get the first index.
    BlobKey blobKey = blobKeys.get(0);

    // User submitted empty file
    BlobInfo blobInfo = new BlobInfoFactory().loadBlobInfo(blobKey);
    if (blobInfo.getSize() == 0) {
      blobstoreService.delete(blobKey);
      return null;
    }

    return blobKey.getKeyString();
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
