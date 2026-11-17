<%@ page import="com.skillgap.model.Student" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%
    Student student = (Student) session.getAttribute("student");

    if (student == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String name = student.getFullName();

    if (name == null || name.trim().isEmpty()) {
        name = "Student";
    }

    String initial = name.substring(0, 1).toUpperCase();
%>

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Dashboard | SkillGap</title>

<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700;800&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

:root {
    --bg: #080b18;
    --panel: #11162a;
    --border: rgba(255,255,255,0.08);
    --text: #f4f5ff;
    --muted: #969db8;
    --purple: #9b8cff;
    --teal: #48d9c2;
}

body {
    font-family: 'DM Sans', sans-serif;
    background:
        radial-gradient(ellipse at 75% 0%, rgba(100,78,220,0.15), transparent 35%),
        radial-gradient(ellipse at 5% 55%, rgba(39,174,166,0.07), transparent 35%),
        var(--bg);
    color: var(--text);
    min-height: 100vh;
}

a {
    text-decoration: none;
}

.layout {
    display: flex;
    min-height: 100vh;
}

/* SIDEBAR */

.sidebar {
    width: 245px;
    flex-shrink: 0;
    background: rgba(12,16,33,0.96);
    border-right: 1px solid var(--border);
    padding: 30px 19px;
    display: flex;
    flex-direction: column;
}

.brand {
    font-family: 'Manrope', sans-serif;
    font-size: 25px;
    font-weight: 800;
    letter-spacing: -1px;
    margin-bottom: 9px;
    color: white;
}

.brand span {
    color: var(--purple);
}

.brand-description {
    color: #858da9;
    font-size: 9px;
    line-height: 1.8;
    letter-spacing: 1px;
    margin-bottom: 38px;
}

.menu-title {
    color: #747e9d;
    font-size: 10px;
    font-weight: 700;
    letter-spacing: 1.7px;
    margin: 0 12px 15px;
}

.nav-link {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 13px;
    margin-bottom: 6px;
    border-radius: 9px;
    color: #aeb5ce;
    font-size: 12px;
    font-weight: 500;
    transition: 0.25s;
}

.nav-link:hover,
.nav-link.active {
    color: white;
    background: linear-gradient(
        100deg,
        rgba(135,117,255,0.22),
        rgba(135,117,255,0.07)
    );
}

.nav-link.active {
    border: 1px solid rgba(155,140,255,0.2);
}

.nav-icon {
    width: 19px;
    text-align: center;
    font-size: 15px;
}

.logout {
    margin-top: auto;
    color: #ff999f;
}

.logout:hover {
    background: rgba(255,100,120,0.10);
}

/* MAIN CONTENT */

.main {
    flex: 1;
    min-width: 0;
    padding: 38px 42px;
}

/* TOPBAR */

.topbar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 15px;
    margin-bottom: 55px;
}

.topbar h2 {
    font-family: 'Manrope', sans-serif;
    font-size: 36px;
    font-weight: 800;
    line-height: 1.3;
    color: #f4f5ff;
    margin-bottom: 9px;
}

.topbar p {
    color: var(--muted);
    font-size: 13px;
}

.user {
    display: flex;
    align-items: center;
    gap: 11px;
    color: #e7e9f7;
    font-size: 12px;
    font-weight: 600;
}

.avatar {
    width: 43px;
    height: 43px;
    border-radius: 50%;
    display: grid;
    place-items: center;
    background: linear-gradient(135deg, #7568e9, #a18cff);
    color: white;
    font-size: 16px;
    font-weight: 800;
    box-shadow: 0 0 22px rgba(139,119,255,0.2);
}

/* SECTION HEADING */

.section-heading {
    margin-bottom: 25px;
}

.section-heading h2 {
    font-family: 'Manrope', sans-serif;
    font-size: 22px;
    font-weight: 800;
    color: #f4f5ff;
}

/* PROJECT CARDS */

.cards {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 19px;
}

.card {
    position: relative;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    min-height: 205px;
    padding: 24px;
    border-radius: 14px;
    border: 1px solid var(--border);
    background: linear-gradient(145deg, #151b31, #101629);
    transition: 0.28s;
}

.card::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 0;
    height: 2px;
    background: linear-gradient(90deg, var(--purple), var(--teal));
    transition: 0.3s;
}

.card:hover {
    transform: translateY(-5px);
    border-color: rgba(155,140,255,0.35);
    box-shadow: 0 15px 35px rgba(0,0,0,0.2);
}

.card:hover::before {
    width: 100%;
}

.card-icon {
    width: 43px;
    height: 43px;
    display: grid;
    place-items: center;
    border-radius: 12px;
    color: #c0b4ff;
    background: rgba(155,140,255,0.13);
    border: 1px solid rgba(155,140,255,0.13);
    font-size: 19px;
    margin-bottom: 17px;
}

.card h3 {
    color: #f0f1ff;
    font-family: 'Manrope', sans-serif;
    font-size: 14px;
    font-weight: 800;
    margin-bottom: 9px;
}

.card p {
    color: #929bb7;
    font-size: 11px;
    line-height: 1.8;
    margin-bottom: 19px;
}

.card-link {
    color: var(--teal);
    font-size: 11px;
    font-weight: 800;
    margin-top: auto;
    transition: 0.2s;
}

.card-link:hover {
    color: white;
}

/* FOOTER */

.footer {
    text-align: center;
    color: #68718f;
    font-size: 10px;
    line-height: 1.9;
    margin-top: 45px;
    padding: 20px 0 8px;
    border-top: 1px solid var(--border);
}

/* RESPONSIVE */

@media(max-width: 1150px) {

    .main {
        padding: 30px 25px;
    }

    .cards {
        grid-template-columns: repeat(2, minmax(0, 1fr));
    }

}

@media(max-width: 760px) {

    .layout {
        flex-direction: column;
    }

    .sidebar {
        width: 100%;
        padding: 20px;
    }

    .brand-description {
        margin-bottom: 20px;
    }

    .logout {
        margin-top: 8px;
    }

    .main {
        padding: 25px 17px;
    }

    .topbar {
        margin-bottom: 35px;
    }

    .topbar h2 {
        font-size: 28px;
    }

}

@media(max-width: 520px) {

    .cards {
        grid-template-columns: 1fr;
    }

    .user span {
        display: none;
    }

    .topbar h2 {
        font-size: 25px;
    }

}

</style>

</head>

<body>

<div class="layout">

    <!-- SIDEBAR -->

    <aside class="sidebar">

        <div class="brand">Skill<span>Gap.</span></div>

        <div class="brand-description">
            STUDENT SKILL ANALYSIS<br>
            & LEARNING RECOMMENDATIONS
        </div>

        <div class="menu-title">MAIN MENU</div>

        <a href="dashboard.jsp" class="nav-link active">
            <span class="nav-icon">⌂</span>
            Dashboard
        </a>

        <a href="skill-assessment.jsp" class="nav-link">
            <span class="nav-icon">▤</span>
            Skill Assessment
        </a>

        <a href="skill-results.jsp" class="nav-link">
            <span class="nav-icon">◫</span>
            Skill Results
        </a>

        <a href="career-selection.jsp" class="nav-link">
            <span class="nav-icon">◎</span>
            Career Selection
        </a>

        <a href="career-recommendations.jsp" class="nav-link">
            <span class="nav-icon">✧</span>
            Career Recommendations
        </a>

        <a href="learning-resources.jsp" class="nav-link">
            <span class="nav-icon">▧</span>
            Learning Resources
        </a>

        <a href="profile.jsp" class="nav-link">
            <span class="nav-icon">◉</span>
            My Profile
        </a>

        <a href="logout.jsp" class="nav-link logout">
            <span class="nav-icon">↪</span>
            Logout
        </a>

    </aside>

    <!-- MAIN CONTENT -->

    <main class="main">

        <div class="topbar">

            <div>
                <h2>Welcome, <%= name %>!</h2>
                <p>Start exploring your skills and career opportunities.</p>
            </div>

            <div class="user">
                <div class="avatar"><%= initial %></div>
                <span><%= name %></span>
            </div>

        </div>

        <div class="section-heading">
            <h2>Explore Your Learning Journey</h2>
        </div>

        <!-- PROJECT MODULES -->

        <section class="cards">

            <div class="card">
                <div class="card-icon">📝</div>
                <h3>Skill Assessment</h3>
                <p>
                    Assess your knowledge of Java, Python, SQL,
                    HTML and CSS.
                </p>
                <a href="skill-assessment.jsp" class="card-link">
                    Start Assessment →
                </a>
            </div>

            <div class="card">
                <div class="card-icon">📊</div>
                <h3>Skill Results</h3>
                <p>
                    View your assessed skill levels and identify
                    skill gaps.
                </p>
                <a href="skill-results.jsp" class="card-link">
                    View Results →
                </a>
            </div>

            <div class="card">
                <div class="card-icon">🎯</div>
                <h3>Career Selection</h3>
                <p>
                    Select your preferred career path.
                </p>
                <a href="career-selection.jsp" class="card-link">
                    Choose Career →
                </a>
            </div>

            <div class="card">
                <div class="card-icon">✧</div>
                <h3>Career Recommendations</h3>
                <p>
                    Explore career recommendations based on your skills.
                </p>
                <a href="career-recommendations.jsp" class="card-link">
                    View Recommendations →
                </a>
            </div>

            <div class="card">
                <div class="card-icon">📚</div>
                <h3>Learning Resources</h3>
                <p>
                    Find learning materials to improve your
                    technical skills.
                </p>
                <a href="learning-resources.jsp" class="card-link">
                    Explore Resources →
                </a>
            </div>

            <div class="card">
                <div class="card-icon">👤</div>
                <h3>My Profile</h3>
                <p>
                    View your personal details and saved
                    assessment information.
                </p>
                <a href="profile.jsp" class="card-link">
                    View Profile →
                </a>
            </div>

        </section>

        <footer class="footer">
            Student Skill Gap Analysis and Learning Recommendation System
        </footer>

    </main>

</div>

</body>
</html>
