package com.google.servlets;

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
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;  
import javax.servlet.http.Cookie;  

@WebServlet("/handle-notes")
public class HandleNotesServlet extends HttpServlet {

  private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
  private final String COOKIE_NAME = "SFCookie";
  
  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
    
    if(!validateUser(request)) {
      response.setStatus(HttpServletResponse.SC_FORBIDDEN);
      return;
    }

    HttpSession activeSession = request.getSession(false);
    String userId = (String) activeSession.getAttribute("user_id");

    String blobKey = getUploadedFileBlobKey(request, "file");
    String title = request.getParameter("title");
    String school = request.getParameter("school");
    String course = request.getParameter("course");
    // TODO: Not sure how the labels will be separated, will need to parse into array of strings
    String miscLabels = request.getParameter("miscLabels");

    // TODO: Put params into database

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