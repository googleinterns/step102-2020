package com.google.starfish.models;

import java.util.Date;

/** Represents a user */
public class User {

  private long id;
  private String displayPicture;
  private String displayName;
  private Date dateJoined;
  private String email;
  private long points;
  private String school;
  // Array of noteIds that have have been favorited by the user
  private long[] favoriteNotes;

  /** Default constructor that throws null exception if NOT NULL fields are null */
  public User(long id, String displayPicture, String displayName, Date dateJoined, String email, long points, String school, long[] favoriteNotes) {
    if (id == null || email == null || points == null) { throw new ArgumentNullException(); }
    this.id = id;
    this.displayPicture = displayPicture;
    this.displayName = displayName;
    this.dateJoined = dateJoined;
    this.email = email;
    this.points = points;
    this.school = school;
    this.favoriteNotes = favoriteNotes;
  }

  /** Overloaded constructor that takes only NOT NULL fields */
  public User(long id, String email, long points) {
    this.id = id;
    this.email = email;
    this.points = points;
  }
}
