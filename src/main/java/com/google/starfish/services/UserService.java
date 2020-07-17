package com.google.starfish.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;  
import java.sql.ResultSet;  
import javax.sql.DataSource;

/**
 * Service class for Users Table 
 */
public class UserService extends TableService {

  public UserService() {
    super(Table.USERS);
  }
}
