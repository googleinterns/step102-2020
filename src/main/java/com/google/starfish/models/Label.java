package com.google.starfish.models;

import java.util.Objects;

/** Enum declaration for type of label. */
enum Type {
  SCHOOL("School"),
  COURSE("Course"),
  MISC("Misc");

  private final String type;

  private Type(String type) {
    this.type = type;
  }

  public String getType() {
    return this.type;
  }
}

/** Represents a label */
public class Label {

  private String title;
  private Type type;

  public Label(String title, String type) {
    this.title = Objects.requireNonNull(title);
    this.type = Objects.requireNonNull(Type.valueOf(type));
  }

  public String getTitle() {
    return this.title;
  }

  public String getType() {
    return type.getType();
  }
}
