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

@WebServlet("/notes")
public final class NotesServlet extends HttpServlet {

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    String noteId = req.getParameter("id");
  }
}
