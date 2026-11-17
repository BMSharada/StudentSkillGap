
package com.skillgap.controller;

import com.skillgap.dao.SkillAssessmentDAO;
import com.skillgap.model.Student;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;

@WebServlet("/SkillAssessmentServlet")
public class SkillAssessmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("student") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Student student = (Student) session.getAttribute("student");

            int javaLevel = Integer.parseInt(request.getParameter("java"));
            int pythonLevel = Integer.parseInt(request.getParameter("python"));
            int sqlLevel = Integer.parseInt(request.getParameter("sql"));
            int htmlcssLevel = Integer.parseInt(request.getParameter("htmlcss"));

            SkillAssessmentDAO dao = new SkillAssessmentDAO();

            boolean saved = dao.saveAssessment(
                    student.getId(),
                    javaLevel,
                    pythonLevel,
                    sqlLevel,
                    htmlcssLevel
            );

            if (saved) {
                session.setAttribute("java", String.valueOf(javaLevel));
                session.setAttribute("python", String.valueOf(pythonLevel));
                session.setAttribute("sql", String.valueOf(sqlLevel));
                session.setAttribute("htmlcss", String.valueOf(htmlcssLevel));

                response.sendRedirect("skill-results.jsp");
            } else {
                response.getWriter().println("Assessment could not be saved.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error saving assessment.");
        }
    }
}
