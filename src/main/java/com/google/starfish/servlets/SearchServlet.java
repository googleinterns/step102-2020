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

/** Servlet that returns search results for notes based on school and course */
@WebServlet("/search")  
public class SearchServlet extends HttpServlet {  

  private FavoriteNoteService favoriteNoteService = new FavoriteNoteService();

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");  

    String reqSchool = Utils.trimAndLowerCaseString(req.getParameter("school"));
    String reqCourse = Utils.trimAndLowerCaseString(req.getParameter("course"));
    String timespan = Utils.trimAndLowerCaseString(req.getParameter("timespan"));
    Recency recency = Utils.findRecencyByString(timespan);
    // Default recency is all-time
    if (recency == null) recency = Recency.ALL_TIME;
    try {
      Object[][] trendingNotes = null;
      switch(recency) {
        case TODAY:
          trendingNotes = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, FavoriteNoteService.Recency.TODAY, reqSchool, reqCourse);
          break;
        case THIS_WEEK:
          trendingNotes = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, FavoriteNoteService.Recency.THIS_WEEK, reqSchool, reqCourse);
          break;
        case THIS_MONTH:
          trendingNotes = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, FavoriteNoteService.Recency.THIS_MONTH, reqSchool, reqCourse);
          break;
        default:
          // Default to returning trending notes all-time
          trendingNotes = favoriteNoteService.getTrendingNotesBySchoolOrCourse(pool, FavoriteNoteService.Recency.ALL_TIME, reqSchool, reqCourse);
      }
      String json = Utils.convert2DArrayToJSON(trendingNotes);
      res.setContentType("application/json");
      res.getWriter().println(json);
    } catch(SQLException ex) {
      ex.printStackTrace();
    }
  }

}  
