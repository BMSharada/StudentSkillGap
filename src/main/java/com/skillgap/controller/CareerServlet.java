
package com.skillgap.controller;

import com.skillgap.dao.SkillAssessmentDAO;
import com.skillgap.dao.StudentDAO;
import com.skillgap.model.Student;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;

@WebServlet("/CareerServlet")
public class CareerServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("student") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String career = request.getParameter("career");

        if (career == null || career.trim().isEmpty()) {
            response.sendRedirect("career-selection.jsp");
            return;
        }

        career = career.trim();

        Student student = (Student) session.getAttribute("student");

        SkillAssessmentDAO skillDAO = new SkillAssessmentDAO();
        StudentDAO studentDAO = new StudentDAO();

        int[] levels = skillDAO.getAssessment(student.getId());

        if (levels == null) {
            response.sendRedirect("skill-assessment.jsp");
            return;
        }

        boolean saved = studentDAO.updateCareerGoal(
                student.getId(), career);

        if (!saved) {
            response.sendRedirect("career-selection.jsp?error=save");
            return;
        }

        session.setAttribute("career", career);
        session.setAttribute("java", levels[0]);
        session.setAttribute("python", levels[1]);
        session.setAttribute("sql", levels[2]);
        session.setAttribute("htmlcss", levels[3]);

        response.sendRedirect("career-recommendations.jsp");
    }
}
