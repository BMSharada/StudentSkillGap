
<%@ page import="com.skillgap.model.Student" %>
<%@ page import="com.skillgap.dao.SkillAssessmentDAO" %>
<%@ page import="com.skillgap.dao.StudentDAO" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    Student student = (Student) session.getAttribute("student");

    if (student == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    SkillAssessmentDAO dao = new SkillAssessmentDAO();
    int[] levels = dao.getAssessment(student.getId());

    String career = (String) session.getAttribute("career");

    if (career == null) {
        StudentDAO studentDAO = new StudentDAO();
        career = studentDAO.getCareerGoal(student.getId());
    }

    String[] skills = {"Java", "Python", "SQL", "HTML & CSS"};

    String initial = student.getFullName() != null &&
                     !student.getFullName().isEmpty()
                     ? student.getFullName().substring(0, 1).toUpperCase()
                     : "S";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Profile | SkillPath</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'DM Sans', sans-serif;
        }

        body {
            min-height: 100vh;
            background:
                radial-gradient(ellipse at 10% 10%, rgba(112, 75, 220, 0.16), transparent 35%),
                radial-gradient(ellipse at 90% 70%, rgba(25, 190, 180, 0.10), transparent 35%),
                #080d1c;
            color: #f4f5ff;
        }

        .header {
            min-height: 76px;
            padding: 18px 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid rgba(255,255,255,0.08);
            background: rgba(8,13,28,0.75);
        }

        .brand {
            font-size: 24px;
            font-weight: 800;
            letter-spacing: -1px;
            color: #ffffff;
        }

        .brand span {
            color: #9b8aff;
        }

        .header a {
            color: #c2c7dc;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: 0.25s;
        }

        .header a:hover {
            color: #a99aff;
        }

        .container {
            max-width: 1080px;
            margin: 0 auto;
            padding: 45px 25px 60px;
        }

        .heading {
            margin-bottom: 30px;
        }

        .eyebrow {
            color: #a99aff;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 2px;
            margin-bottom: 12px;
        }

        .heading h1 {
            font-size: 34px;
            letter-spacing: -1.2px;
            margin-bottom: 9px;
        }

        .heading p {
            color: #969db6;
            font-size: 14px;
            line-height: 1.7;
        }

        .profile-banner {
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            gap: 22px;
            padding: 30px;
            border: 1px solid rgba(172,153,255,0.23);
            border-radius: 19px;
            background: linear-gradient(115deg, #191c3c, #28245b 65%, #17434b);
            margin-bottom: 35px;
        }

        .profile-banner::after {
            content: "";
            position: absolute;
            width: 220px;
            height: 220px;
            border: 1px solid rgba(255,255,255,0.09);
            border-radius: 50%;
            right: -65px;
            top: -100px;
            box-shadow: 0 0 0 25px rgba(255,255,255,0.025),
                        0 0 0 50px rgba(255,255,255,0.02);
        }

        .avatar {
            width: 76px;
            height: 76px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-size: 29px;
            font-weight: 800;
            color: white;
            background: linear-gradient(135deg, #8068e9, #25b9b0);
            border: 2px solid rgba(255,255,255,0.25);
        }

        .profile-banner h2 {
            font-size: 23px;
            margin-bottom: 7px;
        }

        .profile-banner p {
            color: #c0c5df;
            font-size: 13px;
        }

        .section-title {
            font-size: 19px;
            font-weight: 700;
            margin: 36px 0 17px;
            color: #f0f1ff;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 17px;
        }

        .info-card,
        .career-card,
        .skill-card,
        .action-card {
            background: rgba(20,27,49,0.82);
            border: 1px solid rgba(255,255,255,0.09);
            border-radius: 15px;
        }

        .info-card {
            padding: 23px;
        }

        .label {
            color: #929bb7;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1.2px;
            margin-bottom: 11px;
        }

        .info-card h3 {
            color: #f0f1ff;
            font-size: 16px;
            word-break: break-word;
        }

        .career-card {
            padding: 25px;
            background: linear-gradient(120deg, rgba(37,35,83,0.8), rgba(19,54,61,0.65));
        }

        .career-card h3 {
            color: #b5a5ff;
            font-size: 21px;
            margin-bottom: 9px;
        }

        .career-card p {
            color: #aab2cb;
            font-size: 13px;
            line-height: 1.7;
        }

        .skill-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 17px;
        }

        .skill-card {
            padding: 24px;
            transition: 0.25s;
        }

        .skill-card:hover {
            transform: translateY(-4px);
            border-color: rgba(157,135,255,0.5);
            box-shadow: 0 12px 30px rgba(0,0,0,0.2);
        }

        .skill-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 17px;
        }

        .skill-top h3 {
            color: #f1f2ff;
            font-size: 16px;
        }

        .skill-top span {
            color: #b6a5ff;
            font-size: 14px;
            font-weight: 800;
        }

        .progress {
            height: 9px;
            background: #293149;
            border-radius: 20px;
            overflow: hidden;
        }

        .bar {
            height: 100%;
            width: 0;
            background: linear-gradient(90deg, #8068ed, #28c4b5);
            border-radius: 20px;
            transition: width 0.7s ease;
        }

        .skill-note {
            color: #929bb7;
            font-size: 12px;
            margin-top: 12px;
        }

        .empty-state {
            background: rgba(20,27,49,0.82);
            border: 1px solid rgba(255,255,255,0.09);
            border-radius: 15px;
            padding: 25px;
            color: #aab2cb;
            font-size: 14px;
            line-height: 1.7;
        }

        .action-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 14px;
        }

        .action-card {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 19px;
            text-decoration: none;
            color: #e8eaff;
            font-size: 14px;
            font-weight: 600;
            transition: 0.25s;
        }

        .action-card:hover {
            border-color: rgba(157,135,255,0.5);
            background: rgba(39,43,78,0.9);
            transform: translateY(-3px);
        }

        .action-card span {
            color: #a99aff;
            font-size: 20px;
        }

        .footer {
            text-align: center;
            padding: 27px 15px;
            color: #747e9c;
            font-size: 12px;
            border-top: 1px solid rgba(255,255,255,0.07);
        }

        @media(max-width: 700px) {
            .info-grid,
            .skill-grid,
            .action-grid {
                grid-template-columns: 1fr;
            }

            .container {
                padding: 32px 18px 45px;
            }

            .heading h1 {
                font-size: 27px;
            }

            .profile-banner {
                padding: 22px;
            }

            .avatar {
                width: 60px;
                height: 60px;
                font-size: 23px;
            }

            .profile-banner h2 {
                font-size: 19px;
            }

            .header {
                padding: 17px 5%;
            }

            .brand {
                font-size: 21px;
            }
        }
    </style>
</head>

<body>

<header class="header">
    <div class="brand">SKILL<span>PATH</span></div>
    <a href="dashboard.jsp">← Back to Dashboard</a>
</header>

<main class="container">

    <div class="heading">
        <div class="eyebrow">STUDENT ACCOUNT</div>
        <h1>My Profile</h1>
        <p>View your personal information, career goal and technical skill progress.</p>
    </div>

    <div class="profile-banner">
        <div class="avatar"><%= initial %></div>

        <div>
            <h2><%= student.getFullName() %></h2>
            <p><%= student.getEmail() %></p>
        </div>
    </div>

    <h2 class="section-title">Personal Information</h2>

    <div class="info-grid">
        <div class="info-card">
            <div class="label">FULL NAME</div>
            <h3><%= student.getFullName() %></h3>
        </div>

        <div class="info-card">
            <div class="label">EMAIL ADDRESS</div>
            <h3><%= student.getEmail() %></h3>
        </div>
    </div>

    <h2 class="section-title">Career Information</h2>

    <div class="career-card">
        <div class="label">YOUR SELECTED CAREER GOAL</div>

        <h3><%= career == null ? "Not selected yet" : career %></h3>

        <p>
            <% if (career == null) { %>
                Select a career goal to receive personalized skill recommendations.
            <% } else { %>
                Your learning recommendations and skill targets are based on this career path.
            <% } %>
        </p>
    </div>

    <h2 class="section-title">My Technical Skills</h2>

    <% if (levels != null && levels.length >= 4) { %>

        <div class="skill-grid">

            <% for (int i = 0; i < skills.length; i++) {
                int level = Math.max(0, Math.min(5, levels[i]));
                int percentage = level * 20;

                String note = level == 0 ? "Not assessed" :
                              level <= 2 ? "Basic knowledge" :
                              level <= 4 ? "Good progress" :
                              "Advanced level";
            %>

                <div class="skill-card">

                    <div class="skill-top">
                        <h3><%= skills[i] %></h3>
                        <span><%= level %> / 5</span>
                    </div>

                    <div class="progress">
                        <div class="bar" data-progress="<%= percentage %>"></div>
                    </div>

                    <div class="skill-note"><%= note %></div>

                </div>

            <% } %>

        </div>

    <% } else { %>

        <div class="empty-state">
            <strong>Skill assessment not completed.</strong><br>
            Complete your skill assessment to view your technical skill levels here.
        </div>

    <% } %>

    <h2 class="section-title">Quick Actions</h2>

    <div class="action-grid">

        <a href="skill-assessment.jsp" class="action-card">
            Update Skills <span>→</span>
        </a>

        <a href="career-selection.jsp" class="action-card">
            Choose Career Goal <span>→</span>
        </a>

        <a href="career-recommendations.jsp" class="action-card">
            View Recommendations <span>→</span>
        </a>

        <a href="learning-resources.jsp" class="action-card">
            Learning Resources <span>→</span>
        </a>

        <a href="skill-results.jsp" class="action-card">
            View Skill Results <span>→</span>
        </a>

        <a href="dashboard.jsp" class="action-card">
            Back to Dashboard <span>→</span>
        </a>

    </div>

</main>

<footer class="footer">
    Student Skill Gap Analysis and Learning Recommendation System
    <br><br>
    Learn. Improve. Achieve.
</footer>

<script>
    document.querySelectorAll(".bar").forEach(function(bar) {
        bar.style.width = bar.dataset.progress + "%";
    });
</script>

</body>
</html>
