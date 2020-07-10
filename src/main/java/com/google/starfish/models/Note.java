package com.google.starfish.models;

import java.util.Date;

/** Represents a note */ 
public class Note {

  private long id;
  private long authorId;
  private String school;
  private String course;
  private String title;
  private String sourceUrl;
  private String pdfSource;
  private Date dateCreated;
  private long numDownloads;
  private long numFavorites;
  private String[] miscLabels;

  /** Default constructor that throws null exception if NOT NULL fields are null */
  public Note(long id, 
      long authorId, 
      String school, 
      String course, 
      String title, 
      String sourceUrl, 
      String pdfSource, 
      Date dateCreated, 
      long numDownloads, 
      long numFavorites, 
      String[] miscLabels) {

    if (id == null || 
        authorId == null || 
        school == null || 
        course == null || 
        title == null || 
        sourceUrl == null || 
        dateCreated == null || 
        numDownloads == null || 
        numFavorites == null) { throw new ArgumentNullException(); }

    this.id = id;
    this.authorId = authorId;
    this.school = school;
    this.course = course;
    this.title = title;
    this.sourceUrl = sourceUrl;
    this.pdfSource = pdfSource;
    this.dateCreated = dateCreated;
    this.numDownloads = numDownloads;
    this.numFavorites = numFavorites;
    this.miscLabels = miscLabels;
  }
}
