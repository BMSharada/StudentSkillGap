<%@ page import="com.skillgap.model.Student" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    Student student = (Student) session.getAttribute("student");

    if (student == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String selectedCareer = (String) session.getAttribute("career");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Choose Career | SkillPath</title>

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

        .navbar {
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

        .back-link {
            text-decoration: none;
            color: #c4c8dc;
            font-size: 14px;
            font-weight: 600;
            transition: 0.25s;
        }

        .back-link:hover {
            color: #a99aff;
        }

        .main {
            max-width: 1160px;
            margin: 0 auto;
            padding: 65px 25px 55px;
        }

        .heading {
            text-align: center;
            max-width: 720px;
            margin: 0 auto 48px;
        }

        .eyebrow {
            display: inline-block;
            color: #a99aff;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 2.5px;
            margin-bottom: 18px;
        }

        .heading h1 {
            font-family: 'Manrope', sans-serif;
            font-size: 38px;
            font-weight: 800;
            line-height: 1.25;
            letter-spacing: -1.2px;
            margin-bottom: 16px;
            color: #ffffff;
        }

        .heading p {
            color: #a5acc4;
            font-size: 14px;
            line-height: 1.9;
        }

        .career-grid {
            display: grid;
            grid-template-columns: repeat(6, minmax(0, 1fr));
            gap: 22px;
        }

        .career-card {
            grid-column: span 2;
            min-width: 0;
            min-height: 255px;
            position: relative;
            display: flex;
            flex-direction: column;
            padding: 27px;
            background: linear-gradient(
                145deg,
                rgba(27, 35, 64, 0.94),
                rgba(18, 25, 48, 0.96)
            );
            border: 1px solid rgba(166, 155, 255, 0.15);
            border-radius: 19px;
            cursor: pointer;
            transition: 0.3s ease;
        }

        .career-card:nth-child(4) {
            grid-column: 2 / span 2;
        }

        .career-card:nth-child(5) {
            grid-column: 4 / span 2;
        }

        .career-card:hover {
            transform: translateY(-6px);
            border-color: rgba(157, 137, 255, 0.7);
            box-shadow: 0 16px 38px rgba(0, 0, 0, 0.25);
        }

        .career-card:has(input:checked) {
            border: 2px solid #9582ff;
            background: linear-gradient(
                145deg,
                rgba(69, 54, 133, 0.48),
                rgba(20, 43, 68, 0.95)
            );
            box-shadow: 0 0 25px rgba(137, 112, 255, 0.16);
        }

        .radio {
            position: absolute;
            top: 25px;
            right: 25px;
            width: 19px;
            height: 19px;
            accent-color: #a18cff;
            cursor: pointer;
        }

        .career-icon {
            width: 53px;
            height: 53px;
            border-radius: 15px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 13px;
            font-weight: 800;
            color: #c0b3ff;
            background: rgba(143, 119, 255, 0.15);
            border: 1px solid rgba(158, 137, 255, 0.2);
            margin-bottom: 22px;
        }

        .career-card:nth-child(even) .career-icon {
            color: #73ded2;
            background: rgba(43, 190, 173, 0.12);
            border-color: rgba(43, 190, 173, 0.2);
        }

        .career-card h2 {
            font-family: 'Manrope', sans-serif;
            color: #ffffff;
            font-size: 17px;
            font-weight: 700;
            margin-bottom: 11px;
            padding-right: 15px;
        }

        .career-card p {
            color: #a4adc5;
            font-size: 13px;
            line-height: 1.8;
            flex-grow: 1;
        }

        .choose-label {
            color: #a99aff;
            font-size: 12px;
            font-weight: 700;
            margin-top: 20px;
        }

        .career-card:nth-child(even) .choose-label {
            color: #70d8cc;
        }

        .submit-area {
            text-align: center;
            margin-top: 43px;
        }

        .submit-btn {
            min-width: 300px;
            padding: 16px 27px;
            border: none;
            border-radius: 11px;
            background: linear-gradient(110deg, #7660e8, #9b70ed);
            color: #ffffff;
            font-family: 'DM Sans', sans-serif;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 8px 25px rgba(117, 91, 225, 0.25);
            transition: 0.25s ease;
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(117, 91, 225, 0.38);
        }

        .submit-btn:active {
            transform: scale(0.98);
        }

        .note {
            color: #7f89a5;
            font-size: 12px;
            margin-top: 16px;
        }

        .footer {
            text-align: center;
            padding: 25px 15px;
            color: #707b98;
            font-size: 12px;
            border-top: 1px solid rgba(255,255,255,0.06);
        }

        @media (max-width: 800px) {
            .career-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .career-card,
            .career-card:nth-child(4),
            .career-card:nth-child(5) {
                grid-column: auto;
            }

            .heading h1 {
                font-size: 32px;
            }
        }

        @media (max-width: 550px) {
            .navbar {
                padding: 0 5%;
                height: 68px;
            }

            .brand {
                font-size: 22px;
            }

            .main {
                padding: 45px 17px;
            }

            .heading {
                margin-bottom: 32px;
            }

            .heading h1 {
                font-size: 27px;
            }

            .career-grid {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .career-card {
                min-height: 225px;
            }

            .submit-btn {
                width: 100%;
                min-width: 0;
            }
        }
    </style>
</head>

<body>

<nav class="navbar">
    <div class="brand">SKILL<span>PATH.</span></div>
    <a href="dashboard.jsp" class="back-link">← Back to Dashboard</a>
</nav>

<main class="main">

    <section class="heading">
        <div class="eyebrow">CAREER EXPLORATION</div>

        <h1>Choose Your Career Goal</h1>

        <p>
            Select the career path you want to pursue.
            Your skill assessment results will help identify
            the skills you need to improve for your chosen career.
        </p>
    </section>

    <form action="CareerServlet" method="post">

        <div class="career-grid">

            <label class="career-card">
                <input class="radio" type="radio" name="career"
                       value="Java Developer"
                       <%= "Java Developer".equals(selectedCareer) ? "checked" : "" %>
                       required>

                <div class="career-icon">JV</div>
                <h2>Java Developer</h2>
                <p>
                    Build software applications using Java,
                    object-oriented programming and database connectivity.
                </p>
                <span class="choose-label">Select this career →</span>
            </label>

            <label class="career-card">
                <input class="radio" type="radio" name="career"
                       value="Web Developer"
                       <%= "Web Developer".equals(selectedCareer) ? "checked" : "" %>>

                <div class="career-icon">WEB</div>
                <h2>Web Developer</h2>
                <p>
                    Create attractive and responsive websites
                    using HTML, CSS and JavaScript.
                </p>
                <span class="choose-label">Select this career →</span>
            </label>

            <label class="career-card">
                <input class="radio" type="radio" name="career"
                       value="Python Developer"
                       <%= "Python Developer".equals(selectedCareer) ? "checked" : "" %>>

                <div class="career-icon">PY</div>
                <h2>Python Developer</h2>
                <p>
                    Develop applications and solve programming
                    problems using Python.
                </p>
                <span class="choose-label">Select this career →</span>
            </label>

            <label class="career-card">
                <input class="radio" type="radio" name="career"
                       value="Data Analyst"
                       <%= "Data Analyst".equals(selectedCareer) ? "checked" : "" %>>

                <div class="career-icon">DA</div>
                <h2>Data Analyst</h2>
                <p>
                    Analyse data, write SQL queries and
                    generate useful insights for decision-making.
                </p>
                <span class="choose-label">Select this career →</span>
            </label>

            <label class="career-card">
                <input class="radio" type="radio" name="career"
                       value="Full Stack Developer"
                       <%= "Full Stack Developer".equals(selectedCareer) ? "checked" : "" %>>

                <div class="career-icon">FS</div>
                <h2>Full Stack Developer</h2>
                <p>
                    Develop both frontend and backend
                    parts of complete web applications.
                </p>
                <span class="choose-label">Select this career →</span>
            </label>

        </div>

        <div class="submit-area">
            <button type="submit" class="submit-btn">
                Generate Career Recommendations →
            </button>

            <p class="note">Choose one career path to continue.</p>
        </div>

    </form>

</main>

<footer class="footer">
    Student Skill Gap Analysis and Learning Recommendation System
</footer>

</body>
</html>
