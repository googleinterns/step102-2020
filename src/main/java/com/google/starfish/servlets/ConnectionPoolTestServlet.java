package com.google.starfish.servlets;  

import java.io.IOException;  
import java.io.PrintWriter;  
import java.sql.Connection;  
import java.sql.SQLException;  
import javax.servlet.ServletException;  
import javax.servlet.annotation.WebServlet;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.sql.DataSource;

/** Servlet that checks the status of open database connection pool in the app context. */  
@WebServlet("/test-pool-connection")  
public class ConnectionPoolTestServlet extends HttpServlet {  
  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    PrintWriter out = res.getWriter();  
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");  
    try (Connection conn = pool.getConnection()) {
      if (conn != null) res.getWriter().println("Database is connected!");
    } catch (SQLException ex) {
        res.getWriter().println("Database is not connected");  
    }
  }  
}  
