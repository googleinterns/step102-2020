package com.google.starfish.models;

import java.util.Objects;

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
    this.title = Objects.requireNonNull(title);
    this.type = Objects.requireNonNull(type);
  }
}
