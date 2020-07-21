package com.google.starfish.servlets;  

import java.io.IOException;  
import javax.servlet.ServletException;  
import javax.servlet.annotation.WebServlet;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpSession;  
import javax.servlet.http.Cookie;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import java.util.logging.Level;
import java.util.logging.Logger;

/** Servlet that handles user account logout */  
@WebServlet("/user-logout")  
public class UserLogoutServlet extends HttpServlet {

  private static final Logger LOGGER = Logger.getLogger(UserLogoutServlet.class.getName());
  private final String COOKIE_NAME = "SFCookie";

  @Override 
  public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    // Cookie is unused for now, but will be important once sessions begin to be stored in DB
    Cookie[] cookies = req.getCookies();
    for (Cookie cookie : cookies) {
      if (COOKIE_NAME.equals(cookie.getName())) {
        cookie.setMaxAge(0);
        cookie.setValue(null);
        cookie.setPath("/");
        res.addCookie(cookie);
        break;
      }
    }

    HttpSession activeSession = req.getSession(false);
    if (activeSession == null) {
      LOGGER.log(Level.WARNING, "Can't complete logout. No user is logged in.");
      // Set an error code of 403 if the user is not logged in
      res.setStatus(HttpServletResponse.SC_FORBIDDEN);
      return;
    }
    // If there was an active session, invalidate it now to log out the user
    activeSession.invalidate();
  }
}
