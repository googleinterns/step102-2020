CREATE TABLE IF NOT EXISTS labels ( 
  title VARCHAR(255) PRIMARY KEY, 
  type ENUM('School', 'Course', 'Other') NOT NULL 
); 

CREATE TABLE IF NOT EXISTS users ( 
  id INT PRIMARY KEY AUTO_INCREMENT, 
  display_picture VARCHAR(255), 
  display_name VARCHAR(255), 
  date_joined DATE, 
  email VARCHAR(255) NOT NULL, 
  points INT NOT NULL, 
  school VARCHAR(255), 
  FOREIGN KEY (`school`) 
    REFERENCES `labels` (`title`) 
    ON UPDATE RESTRICT ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS notes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  author_id INT NOT NULL,
  school VARCHAR(255) NOT NULL,
  course VARCHAR(255) NOT NULL,
  title VARCHAR(255) NOT NULL,
  source_url VARCHAR(255) NOT NULL,
  pdf_source VARCHAR(255),
  date_created DATE NOT NULL,
  num_downloads INT NOT NULL,
  FOREIGN KEY (`author_id`)
    REFERENCES `users` (`id`)
    ON DELETE CASCADE,
  FOREIGN KEY (`school`)
    REFERENCES `labels` (`title`),
  FOREIGN KEY (`course`)
    REFERENCES `labels` (`title`),
  CONSTRAINT pdf_or_source_url_not_null check (
    `source_url` IS NOT NULL OR `pdf_source` IS NOT NULL
  )
);

CREATE TABLE IF NOT EXISTS other_note_labels (
  note_id INT NOT NULL,
  label VARCHAR(255) NOT NULL,
  PRIMARY KEY (note_id, label),
  FOREIGN KEY (`note_id`)
    REFERENCES `notes` (`id`)
    ON DELETE CASCADE,
  FOREIGN KEY (`label`)
    REFERENCES `labels` (`title`)
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS favorite_notes (
  user_id INT NOT NULL,
  note_id INT NOT NULL,
  PRIMARY KEY (user_id, note_id),
  FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE CASCADE,
  FOREIGN KEY (`note_id`)
    REFERENCES `notes` (`id`)
    ON DELETE CASCADE
);
