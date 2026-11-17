
package com.skillgap.controller;

import com.skillgap.dao.StudentDAO;
import com.skillgap.model.Student;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        StudentDAO dao = new StudentDAO();

        Student student = dao.loginStudent(email, password);

        if (student != null) {

            HttpSession session = request.getSession();

            session.setAttribute("student", student);

            // Retrieve saved career goal
            String career = dao.getCareerGoal(student.getId());

            if (career != null) {
                session.setAttribute("career", career);
            }

            response.sendRedirect("dashboard.jsp");

        } else {

            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}
