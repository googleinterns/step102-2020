package com.google.starfish.servlets;  

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import java.io.IOException;  
import java.sql.Connection;  
import java.sql.SQLException;  
import java.sql.PreparedStatement;
import java.sql.Types;  
import java.sql.ResultSet;
import java.sql.Date;
import javax.servlet.ServletException;  
import java.security.GeneralSecurityException;
import javax.servlet.annotation.WebServlet;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpSession;  
import javax.servlet.http.Cookie;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.sql.DataSource;
import java.util.Calendar;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;

/** Servlet that handles user registration and authentication. */  
@WebServlet("/user-signin")  
public class UserRegistrationServlet extends HttpServlet {

  private static final Logger LOGGER = Logger.getLogger(UserRegistrationServlet.class.getName());
  private static final String CLIENT_ID = System.getenv("CLIENT_ID");
  private final String COOKIE_NAME = "SFCookie";

  @Override 
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    Cookie[] cookies = req.getCookies();
    String sessionId = null;
    for (Cookie cookie : cookies) {
      if (COOKIE_NAME.equals(cookie.getName())) {
        sessionId = cookie.getValue();
      }
    }
    HttpSession activeSession = req.getSession(false);
    if (activeSession == null) {
      LOGGER.log(Level.WARNING, "No user is logged in.");
      // Set an error code of 403 if the user is not logged in
      res.setStatus(HttpServletResponse.SC_FORBIDDEN);
      return;
    }
    String userId = (String) activeSession.getAttribute("user_id");

    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");
    
    try (Connection conn = pool.getConnection()) {
      String stmt = 
          "SELECT * "
        + "FROM users "
        + "WHERE id=? "
        + "LIMIT 1;";

      try (PreparedStatement userStmt = conn.prepareStatement(stmt)) {
        userStmt.setString(1, userId);
        
        ResultSet rs = userStmt.executeQuery();
        rs.next();

        // TO-DO: Once we have a UserService, we can create a User Object and send it back to client
      }
    } catch (SQLException ex) {
      LOGGER.log(Level.WARNING, "Error while speaking to database:", ex);
      // Set an error code of 500 if the server can't connect to the database
      res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
      res.getWriter().println("INTERNAL SERVER ERROR");
    }
  }

  @Override
  public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    System.out.println("Starting verification");
    GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), JacksonFactory.getDefaultInstance())
      .setAudience(Collections.singletonList(CLIENT_ID))
      .build();
    System.out.println("ending verification");
    try {
      GoogleIdToken idToken = verifier.verify(req.getParameter("idToken"));
      if (idToken == null) {
        res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        res.getWriter().println("INVALID TOKEN ID");
        return;
      }
      System.out.println(idToken);

      Payload payload = idToken.getPayload();

      String userId = payload.getSubject();
      System.out.println("User id is " + userId);

      // Get profile information from payload
      String email = payload.getEmail();
      String name = (String) payload.get("name");
      String pictureUrl = (String) payload.get("picture");
      String givenName = (String) payload.get("given_name");

      DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");

      try (Connection conn = pool.getConnection()) {
        boolean userExists = checkIfUserExists(conn, userId);
        // Do nothing if the user already exists
        if (!userExists) {
          System.out.println("user doesn't exist");
          String stmt =
              "INSERT INTO users ( "
                  + "id,"
                  + "display_picture,"
                  + "display_name,"
                  + "date_joined,"
                  + "email,"
                  + "points,"
                  + "school ) "
            + "VALUES ( "
                  + "?,"
                  + "?,"
                  + "?,"
                  + "?,"
                  + "?,"
                  + "?,"
                  + "? ); ";
          try (PreparedStatement userStmt = conn.prepareStatement(stmt)) {
            userStmt.setString(1, userId);
            userStmt.setString(2, pictureUrl);
            userStmt.setString(3, givenName);
            userStmt.setDate(4, new Date(Calendar.getInstance().getTimeInMillis()));
            userStmt.setString(5, email);
            // User starts with 0 points
            userStmt.setInt(6, 0);
            userStmt.setNull(7, Types.VARCHAR);

            // Finally, execute the statement. If it fails, an error will be thrown
            userStmt.execute();

          }
        }

        // Create new user session and save as cookie on client side
        HttpSession newSession = req.getSession(true);
        newSession.setAttribute("user_id", userId);
        Cookie activeSession = new Cookie("SFCookie", newSession.getId());
        res.addCookie(activeSession);

        // TO-DO: Once we have a UserService, we can create a User object and send that back to client

      } catch (SQLException ex) {
        LOGGER.log(Level.WARNING, "Error while attempting to insert new user.", ex);
        // Set an error code of 500 if the server can't connect to the database
        res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        res.getWriter().println("INTERNAL SERVER ERROR");
      }
    } catch (GeneralSecurityException ex) {
      LOGGER.log(Level.WARNING, "Error while attempting to validate user token.", ex);
    }
  }

  private boolean checkIfUserExists(Connection conn, String userId) throws SQLException {
    String stmt = "SELECT EXISTS(SELECT * FROM users WHERE id=?);";
    try (PreparedStatement userExistsStmt = conn.prepareStatement(stmt)) {
      userExistsStmt.setString(1, userId);
      ResultSet userExistsResult = userExistsStmt.executeQuery();
      userExistsResult.next();
      return userExistsResult.getBoolean(1);
    } 
  }
}
