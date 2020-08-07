package com.google.starfish.servlets;

import com.google.appengine.api.blobstore.BlobInfo;
import com.google.appengine.api.blobstore.BlobInfoFactory;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.protos.cloud.sql.Client.SqlException;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;  
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
@WebServlet("/handle-notes")
public class HandleNotesServlet extends HttpServlet {

  private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
  private LabelService labelService = new LabelService();
  private MiscNoteLabelService miscNoteLabelService = new MiscNoteLabelService();
  
  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    if(!Utils.validateUser(request)) {
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
    
    String pdfSource = "/serve-notes?key=" + blobKey;

    String title = request.getParameter("title");
    String school = request.getParameter("school").toLowerCase();
    String course = request.getParameter("course").toLowerCase();
    String misc = request.getParameter("miscLabels");
    String[] miscLabels;
    // Prevent "null" from being inserted into the database as a label
    if(misc != null && misc.equals("null")) miscLabels = new String[0];
    else miscLabels = misc.split(",");

    DataSource pool = (DataSource) request.getServletContext().getAttribute("my-pool");

    // Insert all labels before inserting note due to foreign key constraint
    addLabels(pool, school, course, miscLabels);
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
              + "0 ); ";

      try (PreparedStatement noteStmt = conn.prepareStatement(stmt, new String[] {"id"})) {
        noteStmt.setString(1, userId);
        noteStmt.setString(2, school);
        noteStmt.setString(3, course);
        noteStmt.setString(4, title);
        noteStmt.setString(5, validateAndGetSourceUrl(sourceUrl, pdfSource));
        noteStmt.setString(6, pdfSource);
        noteStmt.setDate(7, new Date(Calendar.getInstance().getTimeInMillis()));
        int rowsAffected = noteStmt.executeUpdate();
        if (rowsAffected == 1) {
          ResultSet generatedKeys = noteStmt.getGeneratedKeys();
          addMiscLabelsToNewNote(pool, generatedKeys, miscLabels);
        }
      }
    } catch (SQLException ex) {
      response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
      response.getWriter().println("INTERNAL SERVER ERROR: " + ex);
    }    
  }

  /** Inserts a school, course, and array of misc labels to the database */
  private void addLabels(DataSource pool, String school, String course, String[] miscLabels) {
    labelService.insertSchoolLabel(pool, school);
    labelService.insertCourseLabel(pool, course);
    for (String miscLabel : miscLabels) {
      labelService.insertMiscLabel(pool, miscLabel.toLowerCase());
    }
  }

  /** Associates an array of misc labels with a newly added Note in the database */
  private void addMiscLabelsToNewNote(DataSource pool, ResultSet generatedKeys, String[] miscLabels) throws SQLException {
    if (generatedKeys.next()) {
      long noteId = generatedKeys.getLong(1);
      for (String miscLabel : miscLabels) {
        miscNoteLabelService.insertMiscNoteLabel(pool, noteId, miscLabel);
      }
    }
  }

  /** Returns the appropriate source_url string for a note after determining whether 
   *  the note is a Google Doc or a PDF
   */
  private String validateAndGetSourceUrl(String sourceUrl, String pdfSource) {
    if (sourceUrl != null) {
      // If there is a sourceUrl on the request param, this is
      // a google doc set the source url based on the passed param
      return sourceUrl;
    }
    // If there was no sourceUrl, this is an uploaded pdf
    // so set the source url to serve-notes path
    return pdfSource;
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
}
