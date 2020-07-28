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
import com.google.starfish.models.Note;
import com.google.gson.Gson;

/** Servlet that returns trending notes based on a given timespan as a query param */
@WebServlet("/get-trending-notes")  
public class GetTrendingNotesServlet extends HttpServlet {  

  private FavoriteNoteService favoriteNoteService = new FavoriteNoteService();

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");  

    String timespan = trimAndLowerCaseString(req.getParameter("timespan"));
    // Default timespan is all-time
    if (timespan == null) timespan = "all-time";
    try {
      Object[][] trendingNotes = null;
      switch(timespan) {
        case "today":
          trendingNotes = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, FavoriteNoteService.Recency.TODAY, null, null);
          break;
        case "this-week":
          trendingNotes = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, FavoriteNoteService.Recency.THIS_WEEK, null, null);
          break;
        case "this-month":
          trendingNotes = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, FavoriteNoteService.Recency.THIS_MONTH, null, null);
          break;
        default:
          // Default to returning trending notes all-time
          trendingNotes = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, FavoriteNoteService.Recency.ALL_TIME, null, null);
      }
      String json = convert2DArrayToJSON(trendingNotes);
      res.setContentType("application/json");
      res.getWriter().println(json);
    } catch(SQLException ex) {
      System.err.print(ex);
    }
  }

  /** If a string is not null, trims whitespace and makes it all lower case */
  private String trimAndLowerCaseString(String string) {
    if (string == null || string.isEmpty()) return null;
    return string.toLowerCase().trim();
  }

  /** Converts a notes array to JSON */
  private String convert2DArrayToJSON(Object[][] arr) {
    Gson gson = new Gson();
    return gson.toJson(arr);
  }
}  
