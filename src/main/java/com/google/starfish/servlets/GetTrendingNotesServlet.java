package com.google.starfish.servlets;  

import java.io.IOException;  
import java.sql.SQLException;  
import javax.servlet.ServletException;  
import javax.servlet.annotation.WebServlet;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.sql.DataSource;
import com.google.starfish.services.FavoriteNoteService;
import com.google.starfish.services.FavoriteNoteService.Recency;

/** Servlet that returns trending notes based on a given timespan as a query param */
@WebServlet("/get-trending-notes")  
public class GetTrendingNotesServlet extends HttpServlet {  

  private FavoriteNoteService favoriteNoteService = new FavoriteNoteService();

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");  

    String timespan = Utils.trimAndLowerCaseString(req.getParameter("timespan"));
    Recency recency = Utils.findRecencyByString(timespan);
    // Default recency is all-time
    if (recency == null) recency = Recency.ALL_TIME;
    try {
      Object[][] trendingNotes = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, recency, null, null);
      String json = Utils.convert2DArrayToJSON(trendingNotes);
      res.setContentType("application/json");
      res.getWriter().println(json);
    } catch(SQLException ex) {
      System.err.print(ex);
    }
  }
}  
