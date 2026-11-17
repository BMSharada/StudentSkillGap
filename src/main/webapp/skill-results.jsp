
<%@ page import="com.skillgap.model.Student" %>
<%@ page import="com.skillgap.dao.SkillAssessmentDAO" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    Student student = (Student) session.getAttribute("student");

    if (student == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    SkillAssessmentDAO dao = new SkillAssessmentDAO();
    int[] levels = dao.getAssessment(student.getId());

    if (levels == null) {
        response.sendRedirect("skill-assessment.jsp");
        return;
    }

    String[] skills = {
        "Java Programming",
        "Python Programming",
        "Database & SQL",
        "HTML & CSS"
    };

    String[] descriptions = {
        "Core programming and object-oriented concepts",
        "Python syntax, functions and programming",
        "Database queries and management",
        "Webpage structure and styling"
    };

    String[] improvements = {
        "Practise OOP concepts, collections and basic coding problems.",
        "Practise syntax, functions, data structures and small programs.",
        "Improve SELECT queries, joins, subqueries and database operations.",
        "Practise page structure, layouts, forms and responsive design."
    };

    String[] icons = {"JAVA", "PY", "SQL", "WEB"};

    int total = 0;
    int weakCount = 0;

    for (int i = 0; i < levels.length; i++) {
        total += levels[i];

        if (levels[i] < 3) {
            weakCount++;
        }
    }

    int score = total * 5;

    String performance;

    if (score >= 80) {
        performance = "Excellent";
    } else if (score >= 60) {
        performance = "Good Progress";
    } else if (score >= 40) {
        performance = "Developing";
    } else {
        performance = "Getting Started";
    }

    boolean hasWeakness = weakCount > 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Skill Assessment Results | SkillPath</title>

    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@500;600;700;800&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'DM Sans', sans-serif;
            background: #090b1b;
            color: #f5f5ff;
            min-height: 100vh;
        }

        a {
            text-decoration: none;
        }

        .page {
            min-height: 100vh;
            background:
                radial-gradient(ellipse at 85% 10%, rgba(139,92,246,0.16), transparent 35%),
                radial-gradient(ellipse at 5% 80%, rgba(45,212,191,0.08), transparent 35%),
                #090b1b;
        }

        .header {
            height: 82px;
            padding: 0 8%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid rgba(255,255,255,0.08);
        }

        .brand {
            font-family: 'Manrope', sans-serif;
            font-size: 19px;
            font-weight: 800;
            color: white;
        }

        .brand span {
            color: #a78bfa;
        }

        .header a {
            color: #c4b5fd;
            font-size: 13px;
            font-weight: 600;
        }

        .header a:hover {
            color: white;
        }

        .container {
            max-width: 1150px;
            margin: auto;
            padding: 55px 25px 65px;
        }

        .eyebrow {
            display: inline-block;
            padding: 8px 15px;
            background: rgba(139,92,246,0.12);
            border: 1px solid rgba(167,139,250,0.25);
            border-radius: 30px;
            color: #c4b5fd;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1.5px;
            margin-bottom: 18px;
        }

        .intro h1 {
            font-family: 'Manrope', sans-serif;
            font-size: 35px;
            letter-spacing: -1px;
            margin-bottom: 12px;
        }

        .intro p {
            color: #a8acc5;
            font-size: 14px;
            line-height: 1.8;
        }

        .score-panel {
            margin-top: 30px;
            padding: 30px;
            border-radius: 20px;
            border: 1px solid rgba(167,139,250,0.2);
            background: linear-gradient(115deg, #242044, #34265f 60%, #234b57);
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.2);
        }

        .score-label {
            color: #c4b5fd;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1.5px;
            margin-bottom: 12px;
        }

        .score-value {
            font-family: 'Manrope', sans-serif;
            font-size: 49px;
            font-weight: 800;
        }

        .score-value span {
            color: #c1bedb;
            font-size: 18px;
        }

        .score-description {
            color: #c7c9dc;
            font-size: 13px;
            margin-top: 7px;
        }

        .score-status {
            padding: 13px 20px;
            border-radius: 10px;
            background: rgba(94,234,212,0.12);
            border: 1px solid rgba(94,234,212,0.3);
            color: #5eead4;
            font-size: 13px;
            font-weight: 700;
        }

        .section-heading {
            margin: 48px 0 21px;
        }

        .section-heading h2 {
            font-family: 'Manrope', sans-serif;
            font-size: 23px;
            margin-bottom: 8px;
        }

        .section-heading p {
            color: #969bb6;
            font-size: 13px;
            line-height: 1.7;
        }

        .skill-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 19px;
        }

        .skill-card {
            padding: 25px;
            border-radius: 17px;
            background: linear-gradient(145deg, rgba(31,35,63,0.9), rgba(17,20,40,0.95));
            border: 1px solid rgba(255,255,255,0.09);
            transition: 0.3s;
        }

        .skill-card:hover {
            transform: translateY(-5px);
            border-color: rgba(167,139,250,0.4);
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
        }

        .skill-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-bottom: 22px;
        }

        .skill-info {
            display: flex;
            align-items: center;
            gap: 13px;
        }

        .skill-icon {
            width: 46px;
            height: 46px;
            flex-shrink: 0;
            display: grid;
            place-items: center;
            border-radius: 13px;
            background: rgba(139,92,246,0.16);
            color: #c4b5fd;
            font-size: 11px;
            font-weight: 800;
        }

        .skill-info h3 {
            font-size: 14px;
            margin-bottom: 6px;
        }

        .skill-info p {
            font-size: 11px;
            line-height: 1.5;
            color: #969bb6;
        }

        .skill-score {
            color: #5eead4;
            font-size: 16px;
            font-weight: 800;
            white-space: nowrap;
        }

        .progress {
            height: 8px;
            border-radius: 20px;
            background: #30334e;
            overflow: hidden;
        }

        .bar {
            height: 100%;
            width: 0;
            border-radius: 20px;
            background: linear-gradient(90deg, #8b5cf6, #2dd4bf);
            transition: width 1s ease;
        }

        .skill-footer {
            display: flex;
            justify-content: space-between;
            margin-top: 12px;
            color: #9da3bd;
            font-size: 12px;
        }

        .skill-footer strong {
            color: #c4b5fd;
        }

        .improvement-list {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 17px;
        }

        .improvement-card {
            padding: 22px;
            border-radius: 15px;
            background: rgba(31,35,63,0.8);
            border: 1px solid rgba(255,255,255,0.08);
            border-left: 3px solid #a78bfa;
        }

        .improvement-card h3 {
            font-size: 14px;
            margin-bottom: 10px;
            color: #e6dcff;
        }

        .improvement-card p {
            color: #a8acc5;
            font-size: 13px;
            line-height: 1.8;
        }

        .success-panel {
            padding: 23px;
            border-radius: 14px;
            background: rgba(45,212,191,0.08);
            border: 1px solid rgba(45,212,191,0.2);
            color: #5eead4;
            font-size: 14px;
            line-height: 1.8;
        }

        .actions {
            display: flex;
            flex-wrap: wrap;
            gap: 13px;
            margin-top: 42px;
        }

        .button {
            display: inline-block;
            padding: 14px 22px;
            border-radius: 10px;
            background: linear-gradient(110deg, #8b5cf6, #6950df);
            color: white;
            font-size: 13px;
            font-weight: 700;
            transition: 0.3s;
        }

        .button:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(139,92,246,0.3);
        }

        .button.secondary {
            background: rgba(255,255,255,0.04);
            border: 1px solid rgba(255,255,255,0.15);
            color: #d8d9ed;
        }

        .button.secondary:hover {
            background: rgba(255,255,255,0.1);
        }

        .footer {
            text-align: center;
            padding: 25px 15px;
            border-top: 1px solid rgba(255,255,255,0.07);
            color: #777e9b;
            font-size: 12px;
        }

        @media(max-width: 700px) {
            .header {
                padding: 0 5%;
            }

            .container {
                padding: 40px 20px;
            }

            .intro h1 {
                font-size: 27px;
            }

            .score-panel {
                align-items: flex-start;
                flex-direction: column;
            }

            .skill-grid,
            .improvement-list {
                grid-template-columns: 1fr;
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
<div class="page">

    <header class="header">
        <div class="brand">SKILL<span>PATH</span></div>
        <a href="dashboard.jsp">← Back to Dashboard</a>
    </header>

    <main class="container">

        <section class="intro">
            <div class="eyebrow">YOUR ASSESSMENT REPORT</div>

            <h1>Your Technical Skills</h1>

            <p>
                Hello, <%= student.getFullName() %>!
                Explore your current technical proficiency and areas
                where you can continue developing your skills.
            </p>
        </section>

        <section class="score-panel">
            <div>
                <div class="score-label">OVERALL SKILL SCORE</div>

                <div class="score-value">
                    <%= score %><span> / 100</span>
                </div>

                <div class="score-description">
                    Combined proficiency across your four assessed skills.
                </div>
            </div>

            <div class="score-status">
                <%= performance %>
            </div>
        </section>

        <section>
            <div class="section-heading">
                <h2>My Technical Skills</h2>
                <p>Your current proficiency level in each technical area.</p>
            </div>

            <div class="skill-grid">

                <% for (int i = 0; i < skills.length; i++) {
                    int percentage = levels[i] * 20;
                %>

                <div class="skill-card">

                    <div class="skill-top">

                        <div class="skill-info">
                            <div class="skill-icon"><%= icons[i] %></div>

                            <div>
                                <h3><%= skills[i] %></h3>
                                <p><%= descriptions[i] %></p>
                            </div>
                        </div>

                        <div class="skill-score">
                            <%= levels[i] %> / 5
                        </div>

                    </div>

                    <div class="progress">
                        <div class="bar" data-progress="<%= percentage %>"></div>
                    </div>

                    <div class="skill-footer">
                        <span>Proficiency</span>
                        <strong><%= percentage %>%</strong>
                    </div>

                </div>

                <% } %>

            </div>
        </section>

        <section>
            <div class="section-heading">
                <h2>Areas for Further Learning</h2>
                <p>Suggested topics to help strengthen your technical knowledge.</p>
            </div>

            <% if (hasWeakness) { %>

                <div class="improvement-list">

                    <% for (int i = 0; i < skills.length; i++) {
                        if (levels[i] < 3) {
                    %>

                        <div class="improvement-card">
                            <h3><%= skills[i] %></h3>
                            <p><%= improvements[i] %></p>
                        </div>

                    <% 
                        }
                    } %>

                </div>

            <% } else { %>

                <div class="success-panel">
                    Your assessed skills are progressing well.
                    Continue practising and exploring advanced concepts.
                </div>

            <% } %>
        </section>

        <div class="actions">
            <a href="skill-assessment.jsp" class="button">
                Retake Assessment →
            </a>

            <a href="career-selection.jsp" class="button secondary">
                Explore Career Goals
            </a>

            <a href="dashboard.jsp" class="button secondary">
                Back to Dashboard
            </a>
        </div>

    </main>

    <footer class="footer">
        Student Skill Gap Analysis and Learning Recommendation System
        <br><br>
        Learn. Improve. Achieve.
    </footer>

</div>

<script>
    document.querySelectorAll(".bar").forEach(function(bar) {
        bar.style.width = bar.dataset.progress + "%";
    });
</script>

</body>
</html>
