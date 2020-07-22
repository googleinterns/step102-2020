package com.google.starfish.servlets;  

import java.io.IOException;  
import javax.servlet.ServletException;  
import javax.servlet.annotation.WebServlet;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.sql.DataSource;
import com.google.starfish.services.MiscNoteLabelService;
import com.google.gson.Gson;

/** Servlet that returns an array of all the most commonly used misc labels onGet */
@WebServlet("/common-labels")  
public class CommonLabelsServlet extends HttpServlet {  

  private MiscNoteLabelService miscNoteLabelService = new MiscNoteLabelService();

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");  
    // TODO: Extract `school` and `course` params in query string
    String[] mostCommonLabels = miscNoteLabelService.getMostUsedMiscLabels(pool /* TODO: , school, course */);
    String json = convertArrayToJSON(mostCommonLabels);
    res.setContentType("application/json");
    res.getWriter().println(json);
  }

  /** Converts a hash map to JSON */
  private String convertArrayToJSON(String[] array) {
    Gson gson = new Gson();
    return gson.toJson(array);
  }
}  
