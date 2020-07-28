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
import com.google.gson.Gson;

/** Servlet that returns search results for notes based on school and course */
@WebServlet("/search")  
public class SearchServlet extends HttpServlet {  

  private FavoriteNoteService favoriteNoteService = new FavoriteNoteService();

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");  

    String reqSchool = trimAndLowerCaseString(req.getParameter("school"));
    String reqCourse = trimAndLowerCaseString(req.getParameter("course"));
    String timespan = trimAndLowerCaseString("timespan");
    try {
      Object[][] trendingNotes = null;
      switch(timespan) {
        case "today":
          trendingNotes = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, FavoriteNoteService.Recency.TODAY, reqSchool, reqCourse);
          break;
        case "this-week":
          trendingNotes = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, FavoriteNoteService.Recency.THIS_WEEK, reqSchool, reqCourse);
          break;
        case "this-month":
          trendingNotes = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, FavoriteNoteService.Recency.THIS_MONTH, reqSchool, reqCourse);
          break;
        default:
          // Default to returning trending notes all-time
          trendingNotes = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, FavoriteNoteService.Recency.ALL_TIME, reqSchool, reqCourse);
      }
      String json = convert2DArrayToJSON(trendingNotes);
      res.setContentType("application/json");
      res.getWriter().println(json);
    } catch(SQLException ex) {
      ex.printStackTrace();
    }
  }

  /** If a string is not null, trims whitespace and makes it all lower case */
  private String trimAndLowerCaseString(String string) {
    if (string == null || string.isEmpty()) return null;
    return string.toLowerCase().trim();
  }

  /** Converts a 2D array to JSON */
  private String convert2DArrayToJSON(Object[][] arr) {
    Gson gson = new Gson();
    return gson.toJson(arr);
  }
}  
