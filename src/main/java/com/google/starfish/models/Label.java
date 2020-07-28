package com.google.starfish.models;

import java.util.Objects;

/** Represents a label */
public class Label {

  private String title;
  private String type;

  public Label(String title, String type) {
    this.title = Objects.requireNonNull(title);
    this.type = Objects.requireNonNull(type);
  }

  public String getTitle() {
    return this.title;
  }

  public String getType() {
    return this.type;
  }
}
