package com.google.starfish.models;

/** Enum declaration for type of label. */
enum Type {
  SCHOOL,
  COURSE,
  MISC
}

/** Represents a label */
public class Label {

  private String title;
  private Type type;

  public Label(String title, Type type) {
    if (title == null || type == null) { throw new ArgumentNullException(); }
    this.title = title;
    this.type = type;
  }
}
