
package com.skillgap.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class DBConnection {

    private static final String URL =
            "jdbc:h2:file:~/StudentSkillGapDB;AUTO_SERVER=TRUE";

    private static final String USER = "sa";
    private static final String PASSWORD = "";

    public static Connection getConnection() {

        try {
            Class.forName("org.h2.Driver");

            Connection con = DriverManager.getConnection(
                    URL, USER, PASSWORD);

            Statement stmt = con.createStatement();

            stmt.executeUpdate(
                "CREATE TABLE IF NOT EXISTS students (" +
                "id INT AUTO_INCREMENT PRIMARY KEY, " +
                "full_name VARCHAR(100) NOT NULL, " +
                "email VARCHAR(100) UNIQUE NOT NULL, " +
                "password VARCHAR(255) NOT NULL, " +
                "career_goal VARCHAR(100))"
            );

            stmt.executeUpdate(
                "ALTER TABLE students ADD COLUMN IF NOT EXISTS career_goal VARCHAR(100)"
            );

            stmt.executeUpdate(
                "CREATE TABLE IF NOT EXISTS skill_assessments (" +
                "student_id INT PRIMARY KEY, " +
                "java_level INT NOT NULL, " +
                "python_level INT NOT NULL, " +
                "sql_level INT NOT NULL, " +
                "htmlcss_level INT NOT NULL, " +
                "assessed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                "FOREIGN KEY (student_id) REFERENCES students(id))"
            );

            stmt.close();

            System.out.println("Database Connected Successfully!");

            return con;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
