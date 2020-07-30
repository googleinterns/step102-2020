package com.google.starfish.servlets;  

import java.io.IOException;  
import javax.servlet.ServletException;  
import javax.servlet.annotation.WebServlet;  
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;  
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import com.google.starfish.models.User;
import com.google.starfish.services.UserService;
import com.google.gson.Gson;
import java.util.HashMap;

/** Servlet that retrieves an author's display name and points. */  
@WebServlet("/get-author-info")  
public class GetAuthorInfoServlet extends HttpServlet {

  private UserService userService = new UserService();

  @Override 
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    String userId = req.getParameter("userId");
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");

    try(Connection conn = pool.getConnection()) {
      if(userId != null && !userId.equals("undefined")) {
        User user = userService.getUserById(pool, userId);
        HashMap<String, String> publicUserInfo = new HashMap<>();
        publicUserInfo.put("displayName", user.getDisplayName());
        publicUserInfo.put("points", String.valueOf(user.getPoints()));
        String json = convertObjectToJSON(publicUserInfo);
        res.setContentType("application/json");
        res.getWriter().println(json);
      }
    } catch (SQLException ex) {
      res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
      res.getWriter().println("INTERNAL SERVER ERROR: " + ex);
    }
  }

  /** Converts an object to JSON */
  private String convertObjectToJSON(HashMap<String, String> user) {
    Gson gson = new Gson();
    return gson.toJson(user);
  }
}
