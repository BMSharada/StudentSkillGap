<%@ page import="com.skillgap.model.Student" %>
<%@ page import="com.skillgap.dao.SkillAssessmentDAO" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    Student student = (Student) session.getAttribute("student");

    if (student == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String career = (String) session.getAttribute("career");

    if (career == null) {
        career = "Java Developer";
    }

    SkillAssessmentDAO dao = new SkillAssessmentDAO();
    int[] levels = dao.getAssessment(student.getId());

    if (levels == null) {
        response.sendRedirect("skill-assessment.jsp");
        return;
    }

    String[] skills = {"Java", "Python", "SQL", "HTML & CSS"};

    int[] requirements;
    String careerDescription;
    String[] learningPlan = new String[4];

    if ("Java Developer".equals(career)) {
        requirements = new int[]{4, 2, 3, 2};
        careerDescription = "Build enterprise software, backend systems and Java-based applications.";
        learningPlan[0] = "Improve Java programming and OOP concepts";
        learningPlan[1] = "Learn JDBC and Java Servlets";
        learningPlan[2] = "Practise SQL queries and database operations";
        learningPlan[3] = "Build Java web applications";

    } else if ("Web Developer".equals(career)) {
        requirements = new int[]{2, 2, 2, 4};
        careerDescription = "Design and develop interactive websites using frontend and backend technologies.";
        learningPlan[0] = "Strengthen HTML page structure";
        learningPlan[1] = "Practise CSS layouts and responsive design";
        learningPlan[2] = "Learn JavaScript fundamentals";
        learningPlan[3] = "Build responsive websites";

    } else if ("Python Developer".equals(career)) {
        requirements = new int[]{2, 4, 3, 2};
        careerDescription = "Develop applications, automate tasks and work with Python programming and databases.";
        learningPlan[0] = "Strengthen Python programming fundamentals";
        learningPlan[1] = "Practise functions and data structures";
        learningPlan[2] = "Learn SQL and database connectivity";
        learningPlan[3] = "Build Python-based applications";

    } else if ("Data Analyst".equals(career)) {
        requirements = new int[]{1, 4, 4, 1};
        careerDescription = "Analyse datasets, identify patterns and transform data into useful insights.";
        learningPlan[0] = "Learn Python for data analysis";
        learningPlan[1] = "Practise SQL queries and joins";
        learningPlan[2] = "Study data cleaning and analysis";
        learningPlan[3] = "Work on practical data analysis projects";

    } else {
        career = "Full Stack Developer";
        requirements = new int[]{3, 2, 3, 4};
        careerDescription = "Develop complete web applications using frontend interfaces, backend logic and databases.";
        learningPlan[0] = "Improve HTML and CSS skills";
        learningPlan[1] = "Learn JavaScript and frontend development";
        learningPlan[2] = "Strengthen Java and backend programming";
        learningPlan[3] = "Practise SQL and build full-stack projects";
    }

    int totalPercentage = 0;
    int meetingCount = 0;

    for (int i = 0; i < 4; i++) {
        totalPercentage +=
            (Math.min(levels[i], requirements[i]) * 100) / requirements[i];

        if (levels[i] >= requirements[i]) {
            meetingCount++;
        }
    }

    int matchScore = totalPercentage / 4;
    int weakCount = 4 - meetingCount;

    String matchLabel;

    if (matchScore >= 80) {
        matchLabel = "Excellent Match";
    } else if (matchScore >= 60) {
        matchLabel = "Good Match";
    } else if (matchScore >= 40) {
        matchLabel = "Developing Match";
    } else {
        matchLabel = "Needs Improvement";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Career Recommendations | SkillPath</title>

    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700;800&family=Manrope:wght@500;600;700;800&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'DM Sans', sans-serif;
            min-height: 100vh;
            color: #f4f3ff;
            background:
                radial-gradient(ellipse at 12% 15%, rgba(105, 75, 220, 0.18), transparent 35%),
                radial-gradient(ellipse at 88% 75%, rgba(25, 190, 177, 0.12), transparent 35%),
                #0b1020;
        }

        .header {
            height: 76px;
            padding: 0 7%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(13, 19, 38, 0.85);
            border-bottom: 1px solid rgba(255,255,255,0.08);
            backdrop-filter: blur(14px);
        }

        .brand {
            font-family: 'Manrope', sans-serif;
            font-size: 25px;
            font-weight: 800;
            color: #ffffff;
            letter-spacing: -1px;
        }

        .brand span {
            color: #9b8aff;
        }

        .header a {
            text-decoration: none;
            color: #c4c8dc;
            font-size: 14px;
            font-weight: 600;
            transition: 0.25s;
        }

        .header a:hover {
            color: #a99aff;
        }

        .container {
            max-width: 1160px;
            margin: 0 auto;
            padding: 55px 25px 60px;
        }

        .eyebrow {
            color: #a99aff;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 2.5px;
            margin-bottom: 14px;
        }

        h1, h2, h3 {
            font-family: 'Manrope', sans-serif;
        }

        h1 {
            color: #ffffff;
            font-size: 35px;
            font-weight: 800;
            letter-spacing: -1px;
            margin-bottom: 12px;
        }

        .intro {
            color: #a5acc4;
            font-size: 14px;
            line-height: 1.8;
            margin-bottom: 30px;
        }

        .career-banner {
            position: relative;
            overflow: hidden;
            padding: 32px;
            border: 1px solid rgba(177, 158, 255, 0.22);
            border-radius: 20px;
            background:
                radial-gradient(circle at 90% 10%, rgba(36, 206, 187, 0.18), transparent 35%),
                linear-gradient(120deg, #292451, #342e72 55%, #194b60);
            margin-bottom: 38px;
        }

        .career-banner .small {
            color: #c4b9ff;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 2px;
            margin-bottom: 13px;
        }

        .career-banner h2 {
            color: #ffffff;
            font-size: 27px;
            margin-bottom: 10px;
        }

        .career-banner p {
            max-width: 680px;
            color: #d1d2e7;
            font-size: 14px;
            line-height: 1.8;
        }

        .section-title {
            color: #ffffff;
            font-size: 21px;
            margin: 35px 0 9px;
        }

        .section-subtitle {
            color: #929db9;
            font-size: 13px;
            line-height: 1.8;
            margin-bottom: 20px;
        }

        .analysis-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
            margin-bottom: 35px;
        }

        .analysis-card {
            padding: 24px;
            background: linear-gradient(145deg, rgba(27, 35, 64, 0.95), rgba(18, 25, 48, 0.95));
            border: 1px solid rgba(166, 155, 255, 0.14);
            border-radius: 16px;
            transition: 0.25s;
        }

        .analysis-card:hover {
            transform: translateY(-4px);
            border-color: rgba(157, 137, 255, 0.45);
        }

        .analysis-card .label {
            color: #a1abc5;
            font-size: 12px;
            margin-bottom: 13px;
        }

        .analysis-card h2 {
            color: #b2a2ff;
            font-size: 31px;
            margin-bottom: 7px;
        }

        .analysis-card:nth-child(2) h2 {
            color: #73ded2;
        }

        .analysis-card:nth-child(3) h2 {
            color: #f0bd83;
        }

        .analysis-card p {
            color: #828da9;
            font-size: 12px;
        }

        .match-card {
            padding: 27px;
            background: rgba(22, 30, 55, 0.92);
            border: 1px solid rgba(166, 155, 255, 0.15);
            border-radius: 17px;
            margin-bottom: 28px;
        }

        .match-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-bottom: 18px;
        }

        .match-top h3 {
            color: #ffffff;
            font-size: 16px;
        }

        .match-number {
            color: #a99aff;
            font-size: 27px;
            font-weight: 800;
        }

        .progress {
            height: 10px;
            background: #303953;
            border-radius: 20px;
            overflow: hidden;
        }

        .bar {
            height: 100%;
            background: linear-gradient(90deg, #7963e8, #a58bff);
            border-radius: 20px;
            transition: width 0.8s ease;
        }

        .skill-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 18px;
        }

        .skill-card {
            padding: 24px;
            background: linear-gradient(145deg, rgba(27, 35, 64, 0.95), rgba(18, 25, 48, 0.95));
            border: 1px solid rgba(166, 155, 255, 0.14);
            border-radius: 16px;
            transition: 0.25s;
        }

        .skill-card:hover {
            transform: translateY(-3px);
            border-color: rgba(157, 137, 255, 0.4);
        }

        .skill-top {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 17px;
        }

        .skill-top h3 {
            color: #ffffff;
            font-size: 15px;
            margin-bottom: 7px;
        }

        .skill-top p {
            color: #8d98b4;
            font-size: 12px;
        }

        .level {
            color: #a99aff;
            font-size: 14px;
            font-weight: 800;
            white-space: nowrap;
        }

        .skill-status {
            font-size: 12px;
            margin-top: 14px;
            font-weight: 700;
        }

        .weak {
            color: #f0bd83;
        }

        .good {
            color: #73ded2;
        }

        .plan-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 17px;
        }

        .plan-card {
            display: flex;
            align-items: flex-start;
            gap: 16px;
            padding: 21px;
            background: linear-gradient(145deg, rgba(27, 35, 64, 0.95), rgba(18, 25, 48, 0.95));
            border: 1px solid rgba(166, 155, 255, 0.14);
            border-radius: 15px;
            transition: 0.25s;
        }

        .plan-card:hover {
            transform: translateY(-3px);
            border-color: rgba(83, 206, 190, 0.4);
        }

        .number {
            width: 36px;
            height: 36px;
            flex-shrink: 0;
            border-radius: 11px;
            background: rgba(143, 119, 255, 0.17);
            border: 1px solid rgba(158, 137, 255, 0.2);
            color: #b9aaff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
        }

        .plan-card p {
            color: #c4cbe0;
            font-size: 13px;
            line-height: 1.7;
            padding-top: 7px;
        }

        .actions {
            display: flex;
            flex-wrap: wrap;
            gap: 13px;
            margin-top: 35px;
        }

        .button {
            display: inline-block;
            padding: 14px 21px;
            border-radius: 10px;
            background: linear-gradient(110deg, #7660e8, #9b70ed);
            color: #ffffff;
            text-decoration: none;
            font-size: 13px;
            font-weight: 700;
            transition: 0.25s;
        }

        .button:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 22px rgba(117, 91, 225, 0.25);
        }

        .button.secondary {
            background: rgba(27, 35, 64, 0.9);
            color: #c5c8e0;
            border: 1px solid rgba(166, 155, 255, 0.2);
        }

        .button.secondary:hover {
            border-color: #9582ff;
            color: #ffffff;
        }

        .note {
            color: #7f89a5;
            font-size: 11px;
            line-height: 1.8;
            margin-top: 24px;
        }

        .footer {
            text-align: center;
            padding: 27px 15px;
            color: #707b98;
            font-size: 12px;
            border-top: 1px solid rgba(255,255,255,0.06);
        }

        @media(max-width: 700px) {
            .header {
                padding: 0 5%;
            }

            .container {
                padding: 40px 17px;
            }

            h1 {
                font-size: 28px;
            }

            .analysis-grid,
            .skill-grid,
            .plan-grid {
                grid-template-columns: 1fr;
            }

            .career-banner {
                padding: 25px;
            }

            .career-banner h2 {
                font-size: 23px;
            }
        }

        @media(max-width: 450px) {
            .brand {
                font-size: 21px;
            }

            .header a {
                font-size: 12px;
            }

            .match-top {
                align-items: flex-start;
                flex-direction: column;
            }

            .actions {
                flex-direction: column;
            }

            .button {
                text-align: center;
            }
        }
    </style>
</head>

<body>

<header class="header">
    <div class="brand">SKILL<span>PATH.</span></div>
    <a href="dashboard.jsp">← Back to Dashboard</a>
</header>

<main class="container">

    <div class="eyebrow">PERSONALIZED CAREER ANALYSIS</div>

    <h1>Your Career Recommendations</h1>

    <p class="intro">
        Welcome, <%= student.getFullName() %>!
        Explore your career match, understand your skill gaps
        and discover what you should learn next.
    </p>

    <section class="career-banner">
        <div class="small">YOUR SELECTED CAREER PATH</div>
        <h2><%= career %></h2>
        <p><%= careerDescription %></p>
    </section>

    <h2 class="section-title">Career Match Analysis</h2>

    <p class="section-subtitle">
        Your assessment compared with the project's defined career skill requirements.
    </p>

    <section class="analysis-grid">

        <div class="analysis-card">
            <div class="label">Overall Career Match</div>
            <h2><%= matchScore %>%</h2>
            <p><%= matchLabel %></p>
        </div>

        <div class="analysis-card">
            <div class="label">Skills Meeting Requirements</div>
            <h2><%= meetingCount %> / 4</h2>
            <p>Skills at or above the target level</p>
        </div>

        <div class="analysis-card">
            <div class="label">Skills to Improve</div>
            <h2><%= weakCount %> / 4</h2>
            <p>Skills currently below the target level</p>
        </div>

    </section>

    <div class="match-card">
        <div class="match-top">
            <h3>Overall Career Match Progress</h3>
            <div class="match-number"><%= matchScore %>%</div>
        </div>

        <div class="progress">
            <div class="bar" data-progress="<%= matchScore %>"></div>
        </div>
    </div>

    <h2 class="section-title">Your Skill Gap Analysis</h2>

    <p class="section-subtitle">
        Compare your current skill level with the target career requirement.
    </p>

    <section class="skill-grid">

        <% for (int i = 0; i < 4; i++) {
            int percentage = Math.min(levels[i], requirements[i]) * 100 / requirements[i];
        %>

            <div class="skill-card">

                <div class="skill-top">
                    <div>
                        <h3><%= skills[i] %></h3>
                        <p>Target: <%= requirements[i] %>/5</p>
                    </div>

                    <div class="level"><%= levels[i] %>/5</div>
                </div>

                <div class="progress">
                    <div class="bar" data-progress="<%= percentage %>"></div>
                </div>

                <% if (levels[i] >= requirements[i]) { %>

                    <div class="skill-status good">
                        ✓ Requirement achieved
                    </div>

                <% } else { %>

                    <div class="skill-status weak">
                        ↑ Improve by <%= requirements[i] - levels[i] %> level(s)
                    </div>

                <% } %>

            </div>

        <% } %>

    </section>

    <h2 class="section-title">Your Personalized Learning Plan</h2>

    <p class="section-subtitle">
        Recommended areas to help you prepare for your selected career.
    </p>

    <section class="plan-grid">

        <% for (int i = 0; i < learningPlan.length; i++) { %>

            <div class="plan-card">
                <div class="number"><%= i + 1 %></div>
                <p><%= learningPlan[i] %></p>
            </div>

        <% } %>

    </section>

    <div class="actions">

        <a href="learning-resources.jsp" class="button">
            Explore Learning Resources →
        </a>

        <a href="career-selection.jsp" class="button secondary">
            Change Career Goal
        </a>

        <a href="dashboard.jsp" class="button secondary">
            Back to Dashboard
        </a>

    </div>

    <p class="note">
        Note: Career match scores are calculated using the skill levels
        and project-defined requirements. They are indicative estimates,
        not guaranteed employment or industry certification scores.
    </p>

</main>

<footer class="footer">
    Student Skill Gap Analysis and Learning Recommendation System
</footer>

<script>
    document.querySelectorAll(".bar").forEach(function(bar) {
        bar.style.width = bar.dataset.progress + "%";
    });
</script>

</body>
</html>