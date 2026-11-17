package com.skillgap.dao;

import com.skillgap.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SkillAssessmentDAO {

    public boolean saveAssessment(int studentId,
                                  int javaLevel,
                                  int pythonLevel,
                                  int sqlLevel,
                                  int htmlcssLevel) {

        String sql = "MERGE INTO skill_assessments " +
                "(student_id, java_level, python_level, sql_level, htmlcss_level) " +
                "KEY(student_id) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setInt(2, javaLevel);
            ps.setInt(3, pythonLevel);
            ps.setInt(4, sqlLevel);
            ps.setInt(5, htmlcssLevel);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public int[] getAssessment(int studentId) {

        String sql = "SELECT java_level, python_level, sql_level, " +
                "htmlcss_level FROM skill_assessments WHERE student_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return new int[]{
                        rs.getInt("java_level"),
                        rs.getInt("python_level"),
                        rs.getInt("sql_level"),
                        rs.getInt("htmlcss_level")
                    };
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}