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
    if (recency == null) recency = Recency.ALL_TIME;
    // Default timespan is all-time
    try {
      Object[][] trendingNotes = null;
      switch(recency) {
        case TODAY:
          trendingNotes = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, FavoriteNoteService.Recency.TODAY, null, null);
          break;
        case THIS_WEEK:
          trendingNotes = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, FavoriteNoteService.Recency.THIS_WEEK, null, null);
          break;
        case THIS_MONTH:
          trendingNotes = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, FavoriteNoteService.Recency.THIS_MONTH, null, null);
          break;
        default:
          // Default to returning trending notes all-time
          trendingNotes = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, FavoriteNoteService.Recency.ALL_TIME, null, null);
      }
      String json = Utils.convert2DArrayToJSON(trendingNotes);
      res.setContentType("application/json");
      res.getWriter().println(json);
    } catch(SQLException ex) {
      System.err.print(ex);
    }
  }
}  
