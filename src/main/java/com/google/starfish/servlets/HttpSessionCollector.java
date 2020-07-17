package com.google.starfish.servlets;

import javax.servlet.http.HttpSession;  
import javax.servlet.http.HttpSessionListener;
import javax.servlet.http.HttpSessionEvent;
import java.util.Map;
import java.util.HashMap;
import javax.servlet.annotation.WebListener;

/** Listens to session creation and deletion and collects sessions in a map, mapping id to session */
@WebListener
public class HttpSessionCollector implements HttpSessionListener {
  private static final Map<String, HttpSession> sessions = new HashMap<>();

  /** Add the session to the sessions map when a new session is created */
  @Override
  public void sessionCreated(HttpSessionEvent event) {
    HttpSession session = event.getSession();
    sessions.put(session.getId(), session);
  }

  /** Remove the session from the sessions map when a session is destroyed */
  @Override
  public void sessionDestroyed(HttpSessionEvent event) {
    sessions.remove(event.getSession().getId());
  }

  /** Returns session by id if it exists, else returns null */
  public static HttpSession find(String sessionId) {
    if (sessions.containsKey(sessionId)) return sessions.get(sessionId);
    return null;
  }

  /** Prints all existing sessions */
  public static void showAllSessions() {
    System.out.println("showing all sessions");
    System.out.println(sessions.size());
    for (Map.Entry<String,HttpSession> entry : sessions.entrySet()) {
      System.out.println("Key = " + entry.getKey());
    }
  }
}
