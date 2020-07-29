package com.google.starfish.models;

import java.util.Date;
import java.util.Objects;

/** Represents a user */
public class User {

  private String id;
  private String displayPicture;
  private String displayName;
  private Date dateJoined;
  private String email;
  private long points;
  private String school;
  // Array of noteIds that have have been favorited by the user
  private Note[] favoriteNotes;
  // Array of noteIds that have have been uploaded by the user
  private Note[] uploadedNotes;

  public static class Builder {

    private String id;
    private String displayPicture;
    private String displayName;
    private Date dateJoined;
    private String email;
    private long points;
    private String school;
    private Note[] favoriteNotes;
    private Note[] uploadedNotes;

    public Builder setId(String id) {
      this.id = id;
      return this;
    }

    public Builder setOptionalDisplayProperties(String displayPicture, String displayName) {
      this.displayPicture = displayPicture;
      this.displayName = displayName;
      return this;
    }

    public Builder setDateJoined(Date dateJoined) {
      this.dateJoined = dateJoined;
      return this;
    }

    public Builder setEmail(String email) {
      this.email = email;
      return this;
    }

    public Builder setPoints(long points) {
      this.points = points;
      return this;
    }

    public Builder setOptionalSchool(String school) {
      this.school = school;
      return this;
    } 

    public Builder setOptionalFavoriteNotes(Note[] favoriteNotes) {
      this.favoriteNotes = favoriteNotes;
      return this;
    }

    public Builder setOptionalUploadedNotes(Note[] uploadedNotes) {
      this.uploadedNotes = uploadedNotes;
      return this;
    }

    public User build() {
      return new User(this.id,
                      this.displayPicture,
                      this.displayName,
                      this.dateJoined,
                      this.email,
                      this.points,
                      this.school,
                      this.favoriteNotes,
                      this.uploadedNotes);
    }
  }

  /** Default constructor that throws null exception if NOT NULL fields are null */
  public User(String id, 
              String displayPicture, 
              String displayName, 
              Date dateJoined, 
              String email, 
              long points, 
              String school, 
              Note[] favoriteNotes,
              Note[] uploadedNotes
  ) {

    this.id = Objects.requireNonNull(id);
    this.displayPicture = displayPicture;
    this.displayName = displayName;
    this.dateJoined = dateJoined;
    this.email = Objects.requireNonNull(email);
    this.points = Objects.requireNonNull(points);
    this.school = school;
    this.favoriteNotes = favoriteNotes;
    this.uploadedNotes = uploadedNotes;
  }

  public String getDisplayName() {
    return this.displayName;
  }

  public long getPoints() {
    return this.points;
  }
}
