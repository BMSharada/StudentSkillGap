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
    String[] icons = {"JAVA", "PY", "SQL", "WEB"};

    String[] descriptions = {
        "Learn Java fundamentals, object-oriented programming, classes, methods and application development.",
        "Learn Python syntax, functions, data structures and practical programming.",
        "Practise SQL queries, filtering, joins, subqueries and database operations.",
        "Learn webpage structure, styling, forms, layouts and responsive web design."
    };

    String[] resourceLinks = {
        "https://www.w3schools.com/java/",
        "https://www.w3schools.com/python/",
        "https://www.w3schools.com/sql/",
        "https://www.w3schools.com/html/",
        "https://www.w3schools.com/css/"
    };

    int[] requirements;

    if ("Java Developer".equals(career)) {
        requirements = new int[]{4, 2, 3, 2};
    } else if ("Web Developer".equals(career)) {
        requirements = new int[]{2, 2, 2, 4};
    } else if ("Python Developer".equals(career)) {
        requirements = new int[]{2, 4, 3, 2};
    } else if ("Data Analyst".equals(career)) {
        requirements = new int[]{1, 4, 4, 1};
    } else {
        requirements = new int[]{3, 2, 3, 4};
    }

    int totalProgress = 0;
    int weakCount = 0;

    for (int i = 0; i < 4; i++) {
        totalProgress += levels[i] * 20;

        if (levels[i] < requirements[i]) {
            weakCount++;
        }
    }

    int overallProgress = totalProgress / 4;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Learning Resources | SkillPath</title>

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
            color: #c4c8dc;
            text-decoration: none;
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
            padding: 30px;
            border: 1px solid rgba(177, 158, 255, 0.22);
            border-radius: 20px;
            background:
                radial-gradient(circle at 90% 10%, rgba(36, 206, 187, 0.18), transparent 35%),
                linear-gradient(120deg, #292451, #342e72 55%, #194b60);
            margin-bottom: 25px;
        }

        .career-banner .small {
            color: #c4b9ff;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 2px;
            margin-bottom: 12px;
        }

        .career-banner h2 {
            color: #ffffff;
            font-size: 25px;
            margin-bottom: 9px;
        }

        .career-banner p {
            color: #d1d2e7;
            font-size: 13px;
            line-height: 1.8;
        }

        .overview-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 18px;
            margin-bottom: 36px;
        }

        .overview-card {
            padding: 25px;
            background: linear-gradient(145deg, rgba(27, 35, 64, 0.95), rgba(18, 25, 48, 0.95));
            border: 1px solid rgba(166, 155, 255, 0.14);
            border-radius: 16px;
            transition: 0.25s;
        }

        .overview-card:hover {
            transform: translateY(-4px);
            border-color: rgba(157, 137, 255, 0.45);
        }

        .overview-card .label {
            color: #a1abc5;
            font-size: 12px;
            margin-bottom: 12px;
        }

        .overview-card h2 {
            color: #b2a2ff;
            font-size: 31px;
            margin-bottom: 7px;
        }

        .overview-card:nth-child(2) h2 {
            color: #73ded2;
        }

        .overview-card p {
            color: #828da9;
            font-size: 12px;
            line-height: 1.6;
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
            transform: translateY(-4px);
            border-color: rgba(157, 137, 255, 0.45);
        }

        .skill-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-bottom: 19px;
        }

        .skill-info {
            display: flex;
            align-items: center;
            gap: 13px;
        }

        .skill-icon {
            width: 45px;
            height: 45px;
            flex-shrink: 0;
            border-radius: 13px;
            background: rgba(143, 119, 255, 0.15);
            border: 1px solid rgba(158, 137, 255, 0.2);
            color: #c0b3ff;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 11px;
            font-weight: 800;
        }

        .skill-card:nth-child(even) .skill-icon {
            color: #73ded2;
            background: rgba(43, 190, 173, 0.12);
            border-color: rgba(43, 190, 173, 0.2);
        }

        .skill-info h3 {
            color: #ffffff;
            font-size: 15px;
            margin-bottom: 6px;
        }

        .skill-info p {
            font-size: 11px;
            color: #8d98b4;
        }

        .level {
            font-size: 14px;
            color: #b2a2ff;
            font-weight: 800;
            white-space: nowrap;
        }

        .progress {
            height: 9px;
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

        .skill-card:nth-child(even) .bar {
            background: linear-gradient(90deg, #249e9a, #73ded2);
        }

        .skill-details {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: 14px;
            font-size: 12px;
            color: #929db9;
        }

        .resource-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 18px;
        }

        .resource-card {
            min-height: 180px;
            display: flex;
            flex-direction: column;
            padding: 24px;
            background: linear-gradient(145deg, rgba(27, 35, 64, 0.95), rgba(18, 25, 48, 0.95));
            border: 1px solid rgba(166, 155, 255, 0.14);
            border-radius: 16px;
            transition: 0.25s;
        }

        .resource-card:hover {
            transform: translateY(-4px);
            border-color: rgba(83, 206, 190, 0.4);
        }

        .resource-card h3 {
            color: #ffffff;
            font-size: 16px;
            margin-bottom: 10px;
        }

        .resource-card p {
            color: #a0abc4;
            font-size: 13px;
            line-height: 1.8;
            flex: 1;
        }

        .resource-link {
            display: inline-block;
            margin-top: 18px;
            color: #a99aff;
            font-size: 13px;
            font-weight: 800;
            text-decoration: none;
            transition: 0.2s;
        }

        .resource-link:hover {
            color: #73ded2;
        }

        .actions {
            display: flex;
            flex-wrap: wrap;
            gap: 13px;
            margin-top: 36px;
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

            .overview-grid,
            .skill-grid,
            .resource-grid {
                grid-template-columns: 1fr;
            }

            .career-banner {
                padding: 25px;
            }
        }

        @media(max-width: 450px) {
            .brand {
                font-size: 21px;
            }

            .header a {
                font-size: 12px;
            }

            .skill-top {
                align-items: flex-start;
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

    <div class="eyebrow">PERSONALIZED LEARNING</div>

    <h1>Learning Resources</h1>

    <p class="intro">
        Track your technical skills and explore learning resources
        based on your selected career goal.
    </p>

    <section class="career-banner">
        <div class="small">YOUR SELECTED CAREER PATH</div>
        <h2><%= career %></h2>
        <p>
            Your learning roadmap is based on your selected career
            and the skill levels you submitted in your assessment.
        </p>
    </section>

    <section class="overview-grid">

        <div class="overview-card">
            <div class="label">Overall Skill Progress</div>
            <h2><%= overallProgress %>%</h2>
            <p>Average proficiency across your four assessed skills</p>
        </div>

        <div class="overview-card">
            <div class="label">Skills Requiring Improvement</div>
            <h2><%= weakCount %> / 4</h2>
            <p>Skills currently below their career target level</p>
        </div>

    </section>

    <h2 class="section-title">Your Skill Progress</h2>

    <p class="section-subtitle">
        Current level compared with your selected career target.
    </p>

    <section class="skill-grid">

        <% for (int i = 0; i < 4; i++) {
            int percentage = levels[i] * 20;
        %>

            <div class="skill-card">

                <div class="skill-top">

                    <div class="skill-info">
                        <div class="skill-icon"><%= icons[i] %></div>

                        <div>
                            <h3><%= skills[i] %></h3>
                            <p>Technical skill assessment</p>
                        </div>
                    </div>

                    <div class="level"><%= levels[i] %> / 5</div>

                </div>

                <div class="progress">
                    <div class="bar" data-progress="<%= percentage %>"></div>
                </div>

                <div class="skill-details">
                    <span>Current: <%= levels[i] %>/5</span>
                    <span>Target: <%= requirements[i] %>/5</span>
                </div>

            </div>

        <% } %>

    </section>

    <h2 class="section-title">Recommended Learning Resources</h2>

    <p class="section-subtitle">
        Explore resources to strengthen your four technical skills.
    </p>

    <section class="resource-grid">

        <% for (int i = 0; i < 4; i++) { %>

            <div class="resource-card">

                <h3><%= skills[i] %></h3>

                <p><%= descriptions[i] %></p>

                <a class="resource-link"
                   href="<%= resourceLinks[i] %>"
                   target="_blank"
                   rel="noopener noreferrer">
                    Start Learning →
                </a>

            </div>

        <% } %>

    </section>

    <h2 class="section-title">Additional Web Development Resources</h2>

    <p class="section-subtitle">
        Explore HTML and CSS separately to strengthen your frontend development skills.
    </p>

    <section class="resource-grid">

        <div class="resource-card">
            <h3>HTML Tutorial</h3>
            <p>Learn elements, forms, tables, semantic tags and webpage structure.</p>
            <a class="resource-link"
               href="<%= resourceLinks[3] %>"
               target="_blank"
               rel="noopener noreferrer">
                Explore HTML →
            </a>
        </div>

        <div class="resource-card">
            <h3>CSS Tutorial</h3>
            <p>Learn colours, spacing, flexbox, grid, animations and responsive layouts.</p>
            <a class="resource-link"
               href="<%= resourceLinks[4] %>"
               target="_blank"
               rel="noopener noreferrer">
                Explore CSS →
            </a>
        </div>

    </section>

    <div class="actions">

        <a href="dashboard.jsp" class="button">
            Back to Dashboard
        </a>

        <a href="skill-results.jsp" class="button secondary">
            View Skill Results
        </a>

        <a href="profile.jsp" class="button secondary">
            My Profile
        </a>

    </div>

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