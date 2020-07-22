package com.google.starfish.servlets;  

import java.io.IOException;  
import javax.servlet.ServletException;  
import javax.servlet.annotation.WebServlet;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.sql.DataSource;
import com.google.starfish.services.LabelService;
import com.google.gson.Gson;
import java.util.HashMap;

/** Servlet that returns arrays of all school and course labels onGet */
@WebServlet("/get-school-and-course-labels")  
public class GetSchoolAndCourseLabelsServlet extends HttpServlet {  

  private LabelService labelService = new LabelService();

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    DataSource pool = (DataSource) req.getServletContext().getAttribute("my-pool");  
    HashMap<String, String[]> allSchoolAndCourseLabels = labelService.getAllSchoolAndCourseLabels(pool);
    String json = convertHashMapToJSON(allSchoolAndCourseLabels);
    res.setContentType("application/json");
    res.getWriter().println(json);
  }

  /** Converts a hash map to JSON */
  private String convertHashMapToJSON(HashMap<String, String[]> hashMap) {
    Gson gson = new Gson();
    return gson.toJson(hashMap);
  }
}  
