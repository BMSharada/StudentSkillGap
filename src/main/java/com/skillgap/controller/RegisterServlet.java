package com.skillgap.controller;

import com.skillgap.dao.StudentDAO;
import com.skillgap.model.Student;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Check for empty fields
        if (name == null || email == null || password == null
                || confirmPassword == null
                || name.trim().isEmpty()
                || email.trim().isEmpty()
                || password.isEmpty()
                || confirmPassword.isEmpty()) {

            response.sendRedirect("register.jsp?error=1");
            return;
        }

        // Check password length
        if (password.length() < 6) {
            response.sendRedirect("register.jsp?error=1");
            return;
        }

        // Check whether passwords match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=password");
            return;
        }

        Student student = new Student(
                name.trim(),
                email.trim(),
                password
        );

        StudentDAO dao = new StudentDAO();

        // Save student in database
        if (dao.registerStudent(student)) {

            // Registration successful: show popup on register.jsp
            response.sendRedirect("register.jsp?registered=1");

        } else {

            // Registration failed
            response.sendRedirect("register.jsp?error=1");
        }
    }
}
