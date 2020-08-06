package com.google.starfish.models;

import java.util.Date;
import java.util.Objects;
import java.util.Arrays;

/** Represents a note */ 
public class Note {

  private long id;
  private String authorId;
  private String school;
  private String course;
  private String title;
  private String sourceUrl;
  private String pdfSource;
  private Date dateCreated;
  private long numDownloads;
  private long numFavorites;
  private String[] miscLabels;

  public static class Builder {

    private long id;
    private String authorId;
    private String school;
    private String course;
    private String title;
    private String sourceUrl;
    private String pdfSource;
    private Date dateCreated;
    private long numDownloads;
    private long numFavorites;
    private String[] miscLabels;

    public Builder setId(long id) {
      this.id = id;
      return this;
    }

    public Builder setAuthorId(String authorId) {
      this.authorId = authorId;
      return this;
    }

    public Builder setRequiredLabels(String school, String course) {
      this.school = school;
      this.course = course;
      return this;
    }

    public Builder setNoteTitle(String title) {
      this.title = title;
      return this;
    }

    public Builder setSourceUrl(String sourceUrl) {
      this.sourceUrl = sourceUrl;
      return this;
    }

    public Builder setOptionalPdfSource(String pdfSource) {
      this.pdfSource = pdfSource;
      return this;
    }

    public Builder setDateCreated(Date dateCreated) {
      this.dateCreated = dateCreated;
      return this;
    }

    public Builder setNumDownloads(long numDownloads) {
      this.numDownloads = numDownloads;
      return this;
    }

    public Builder setNumFavorites(long numFavorites) {
      this.numFavorites = numFavorites;
      return this;
    }

    public Builder setMiscLabels(String[] miscLabels) {
      this.miscLabels = miscLabels;
      return this;
    }

    public Note build() {
      return new Note(this.id, 
                      this.authorId, 
                      this.school, 
                      this.course, 
                      this.title, 
                      this.sourceUrl, 
                      this.pdfSource, 
                      this.dateCreated, 
                      this.numDownloads, 
                      this.numFavorites, 
                      this.miscLabels);
    }
  }

  /** Default constructor that throws null exception if NOT NULL fields are null */
  public Note(long id, 
              String authorId, 
              String school, 
              String course, 
              String title, 
              String sourceUrl, 
              String pdfSource, 
              Date dateCreated, 
              long numDownloads, 
              long numFavorites, 
              String[] miscLabels
  ) {
    this.id = Objects.requireNonNull(id);
    this.authorId = Objects.requireNonNull(authorId);
    this.school = Objects.requireNonNull(school);
    this.course = Objects.requireNonNull(course);
    this.title = Objects.requireNonNull(title);
    this.sourceUrl = Objects.requireNonNull(sourceUrl);
    this.pdfSource = pdfSource;
    this.dateCreated = Objects.requireNonNull(dateCreated);
    this.numDownloads = Objects.requireNonNull(numDownloads);
    this.numFavorites = Objects.requireNonNull(numFavorites);
    this.miscLabels = miscLabels;
  }

  @Override
  public boolean equals(final Object obj) {
    if (obj == null || obj == this || !(obj instanceof Note)) return false;
    Note note = (Note) obj;

    if (note.getId() != this.id) return false;
    if (!note.getAuthorId().equals(this.authorId)) return false;
    if (!note.getSchool().equals(this.school)) return false;
    if (!note.getCourse().equals(this.course)) return false;
    if (!note.getTitle().equals(this.title)) return false;
    if (!note.getSourceUrl().equals(this.sourceUrl)) return false;
    if (!note.getPdfSource().equals(this.pdfSource)) return false;
    if (!note.getDateCreated().toString().equals(this.dateCreated.toString())) return false;
    if (note.getNumDownloads() != this.numDownloads) return false;
    if (note.getNumFavorites() != this.numFavorites) return false;
    if (!Arrays.equals(note.getMiscLabels(), this.miscLabels)) return false;

    return true;
  }

  public long getId() {
    return this.id;
  }

  public String getAuthorId() {
    return this.authorId;
  }

  public String getSchool() {
    return this.school;
  }

  public String getCourse() {
    return this.course;
  }

  public String getTitle() {
    return this.title;
  }

  public String getSourceUrl() {
    return this.sourceUrl;
  }

  public String getPdfSource() {
    return this.pdfSource;
  }

  public Date getDateCreated() {
    return this.dateCreated;
  }

  public long getNumDownloads() {
    return this.numDownloads;
  }

  public long getNumFavorites() {
    return this.numFavorites;
  }

  public String[] getMiscLabels() {
    return this.miscLabels;
  }
}
