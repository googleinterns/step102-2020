package com.google.starfish.servlets;

import com.google.appengine.api.blobstore.BlobInfo;
import com.google.appengine.api.blobstore.BlobInfoFactory;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.blobstore.BlobInfoFactory;
import com.google.appengine.api.blobstore.BlobInfo;
import com.google.appengine.api.images.ServingUrlOptions;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;
import java.util.Map;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;  
import javax.servlet.http.Cookie;  
import com.google.starfish.services.NoteService;
import com.google.starfish.services.LabelService;
import com.google.starfish.services.MiscNoteLabelService;
import javax.sql.DataSource;
import java.sql.Connection;  
import java.sql.SQLException;  
import java.sql.PreparedStatement;
import java.sql.Types;  
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Date;
import java.util.Calendar;


@WebServlet("/handle-notes")
public class HandleNotesServlet extends HttpServlet {

  private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
  private final String COOKIE_NAME = "SFCookie";
  private NoteService noteService = new NoteService();
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
    if (blobKey == null) {
      response.setStatus(HttpServletResponse.SC_NOT_ACCEPTABLE);
      return;
    }
    String title = request.getParameter("title");
    String school = request.getParameter("school");
    String course = request.getParameter("course");
    String[] miscLabels = request.getParameter("miscLabels").split(",");

    // TODO: Make SQL queries not auto commit and rollback transaction on catching exception
    
    DataSource pool = (DataSource) request.getServletContext().getAttribute("my-pool");
    
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

      try (PreparedStatement noteStmt = conn.prepareStatement(stmt, Statement.RETURN_GENERATED_KEYS)) {
        noteStmt.setString(1, userId);
        noteStmt.setString(2, school);
        noteStmt.setString(3, course);
        noteStmt.setString(4, title);
        noteStmt.setString(5, blobKey);
        noteStmt.setString(6, blobKey);
        noteStmt.setDate(7, new Date(Calendar.getInstance().getTimeInMillis()));
        noteStmt.setLong(8, 0);
        System.out.println("Posting note");
        int rowsAffected = noteStmt.executeUpdate();
        if (rowsAffected == 1) {
          long noteId = 0;
          ResultSet rs = noteStmt.getGeneratedKeys();
          if (rs.next()) {
            noteId = rs.getLong(1);
            System.out.println("NoteId: " + noteId);

            // Use label services to insert all new labels into the database
            labelService.insertSchoolLabel(pool, school);
            labelService.insertCourseLabel(pool, course);
            for (String miscLabel : miscLabels) {
              labelService.insertMiscLabel(pool, miscLabel);
            }
            for (String miscLabel : miscLabels) {
              miscNoteLabelService.insertMiscNoteLabelById(pool, noteId, miscLabel);
            }
          } 
        }
      }
    } catch (SQLException ex) {
      // LOGGER.log(Level.WARNING, "Error while speaking to database:", ex);
      // Set an error code of 500 if the server can't connect to the database
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
