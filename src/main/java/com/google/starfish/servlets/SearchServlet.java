package com.google.starfish.servlets;  

import java.io.IOException;  
import java.io.PrintWriter;  
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
import com.google.starfish.services.NoteService;

/** Servlet that checks the status of open database connection pool in the app context. */  
@WebServlet("/search")  
public class SearchServlet extends HttpServlet {  

  private NoteService noteService = new NoteService();

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");  
    String school = req.getParameter("school");
    String course = req.getParameter("course");
    try (Connection conn = pool.getConnection()) {
      String stmt = 
          "SELECT * "
        + "FROM `starfish.notes` "
        + "WHERE `school`='" + school + "' AND `course`='" + course + "';";
      try (PreparedStatement getNotesStatement = conn.prepareStatement(stmt)) {
        ResultSet rs = getNotesStatement.executeQuery();

        while (rs.next()) {

        }
      }

    } catch (SQLException ex) {
        res.getWriter().println("Database is not connected");  
    }
  }  
}  
