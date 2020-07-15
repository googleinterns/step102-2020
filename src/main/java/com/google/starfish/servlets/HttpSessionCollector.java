package com.google.starfish.servlets;

import javax.servlet.http.HttpSession;  
import javax.servlet.http.HttpSessionListener;
import javax.servlet.http.HttpSessionEvent;
import java.util.Map;
import java.util.HashMap;
import javax.servlet.annotation.WebListener;

@WebListener
public class HttpSessionCollector implements HttpSessionListener {
  private static final Map<String, HttpSession> sessions = new HashMap<>();

  @Override
  public void sessionCreated(HttpSessionEvent event) {
    HttpSession session = event.getSession();
    sessions.put(session.getId(), session);
  }

  @Override
  public void sessionDestroyed(HttpSessionEvent event) {
    sessions.remove(event.getSession().getId());
  }

  public static HttpSession find(String sessionId) {
    if (sessions.containsKey(sessionId)) return sessions.get(sessionId);
    return null;
  }

  public static void showAllSessions() {
    System.out.println("showing all sessions");
    System.out.println(sessions.size());
    for (Map.Entry<String,HttpSession> entry : sessions.entrySet()) {
      System.out.println("Key = " + entry.getKey());
    }
  }
}
