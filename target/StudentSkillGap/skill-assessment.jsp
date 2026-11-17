<%@ page import="com.skillgap.model.Student" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    Student student = (Student) session.getAttribute("student");

    if (student == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Skill Assessment | SkillGap</title>

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
    --text: #f4f5ff;
    --muted: #969db8;
    --purple: #9b8cff;
    --teal: #48d9c2;
    --border: rgba(255,255,255,0.08);
}

body {
    font-family: 'DM Sans', sans-serif;
    background:
        radial-gradient(ellipse at 75% 0%, rgba(100,78,220,0.16), transparent 35%),
        radial-gradient(ellipse at 5% 55%, rgba(39,174,166,0.08), transparent 35%),
        var(--bg);
    color: var(--text);
    min-height: 100vh;
}

/* Header */

.header {
    height: 76px;
    padding: 0 7%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 1px solid var(--border);
    background: rgba(12,16,33,0.82);
    backdrop-filter: blur(12px);
}

.brand {
    font-family: 'Manrope', sans-serif;
    font-size: 25px;
    font-weight: 800;
    letter-spacing: -1px;
    color: white;
}

.brand span {
    color: var(--purple);
}

.header a {
    color: #c0b8ff;
    font-size: 12px;
    font-weight: 700;
    text-decoration: none;
    transition: 0.2s;
}

.header a:hover {
    color: var(--teal);
}

/* Main */

.container {
    max-width: 1050px;
    margin: 45px auto;
    padding: 0 25px;
}

.intro {
    margin-bottom: 30px;
}

.eyebrow {
    color: var(--teal);
    font-size: 10px;
    font-weight: 800;
    letter-spacing: 2px;
    margin-bottom: 13px;
}

.intro h1 {
    font-family: 'Manrope', sans-serif;
    font-size: clamp(27px, 4vw, 35px);
    font-weight: 800;
    color: white;
    margin-bottom: 12px;
}

.intro h1 span {
    color: var(--purple);
}

.intro p {
    color: var(--muted);
    font-size: 13px;
    line-height: 1.9;
    max-width: 700px;
}

/* Assessment panel */

.assessment-panel {
    background: linear-gradient(145deg, #151b31, #101629);
    border: 1px solid var(--border);
    border-radius: 17px;
    padding: 32px;
    box-shadow: 0 15px 40px rgba(0,0,0,0.16);
}

.panel-heading {
    margin-bottom: 27px;
}

.panel-heading h2 {
    font-family: 'Manrope', sans-serif;
    color: white;
    font-size: 20px;
    margin-bottom: 8px;
}

.panel-heading p {
    color: var(--muted);
    font-size: 12px;
    line-height: 1.7;
}

/* Skill cards */

.skill-grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 19px;
}

.skill-card {
    background: rgba(8,12,27,0.55);
    border: 1px solid var(--border);
    border-radius: 13px;
    padding: 23px;
    min-width: 0;
    transition: 0.25s;
}

.skill-card:hover {
    transform: translateY(-3px);
    border-color: rgba(155,140,255,0.4);
    box-shadow: 0 12px 28px rgba(0,0,0,0.17);
}

.skill-heading {
    display: flex;
    align-items: center;
    gap: 14px;
    margin-bottom: 21px;
}

.skill-icon {
    width: 47px;
    height: 47px;
    flex-shrink: 0;
    border-radius: 12px;
    display: grid;
    place-items: center;
    background: rgba(155,140,255,0.14);
    border: 1px solid rgba(155,140,255,0.15);
    color: #c0b4ff;
    font-size: 14px;
    font-weight: 800;
}

.skill-heading h3 {
    color: #f1f1ff;
    font-family: 'Manrope', sans-serif;
    font-size: 14px;
    margin-bottom: 5px;
}

.skill-heading p {
    color: #929bb7;
    font-size: 11px;
}

.field-label {
    display: block;
    color: #c0c6dc;
    font-size: 12px;
    font-weight: 700;
    margin-bottom: 10px;
}

.skill-select {
    width: 100%;
    height: 47px;
    padding: 0 13px;
    border: 1px solid rgba(255,255,255,0.12);
    border-radius: 8px;
    background: #0c1225;
    color: #e8eaff;
    font-family: 'DM Sans', sans-serif;
    font-size: 12px;
    outline: none;
    cursor: pointer;
    transition: 0.2s;
}

.skill-select:focus {
    border-color: var(--purple);
    box-shadow: 0 0 0 3px rgba(155,140,255,0.12);
}

.skill-select option {
    background: #11162a;
    color: white;
}

/* Level guide */

.level-guide {
    margin-top: 28px;
    padding: 23px;
    background: rgba(72,217,194,0.045);
    border: 1px solid rgba(72,217,194,0.14);
    border-radius: 13px;
}

.level-guide h3 {
    font-family: 'Manrope', sans-serif;
    color: #f0f2ff;
    font-size: 14px;
    margin-bottom: 20px;
}

.level-list {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    gap: 12px;
}

.level-item {
    text-align: center;
}

.level-number {
    width: 36px;
    height: 36px;
    margin: 0 auto 9px;
    border-radius: 10px;
    background: rgba(155,140,255,0.16);
    border: 1px solid rgba(155,140,255,0.2);
    color: #c0b4ff;
    display: grid;
    place-items: center;
    font-weight: 800;
    font-size: 13px;
}

.level-item p {
    color: #aab2ca;
    font-size: 11px;
    font-weight: 600;
}

/* Submit */

.submit-area {
    text-align: center;
    margin-top: 30px;
}

.submit-button {
    border: none;
    background: linear-gradient(105deg, #a99aff, #64ddce);
    color: #10152a;
    padding: 14px 32px;
    border-radius: 9px;
    font-family: 'DM Sans', sans-serif;
    font-size: 13px;
    font-weight: 800;
    cursor: pointer;
    transition: 0.25s;
}

.submit-button:hover {
    transform: translateY(-3px);
    box-shadow: 0 9px 25px rgba(100,221,206,0.16);
}

.submit-button:active {
    transform: scale(0.98);
}

.submit-note {
    margin-top: 13px;
    color: #747e9c;
    font-size: 11px;
}

.footer {
    text-align: center;
    padding: 24px 15px;
    color: #68718f;
    font-size: 10px;
    border-top: 1px solid var(--border);
    margin-top: 45px;
}

/* Responsive */

@media(max-width: 700px) {
    .header {
        padding: 0 20px;
    }

    .container {
        margin: 30px auto;
        padding: 0 16px;
    }

    .assessment-panel {
        padding: 21px;
    }

    .skill-grid {
        grid-template-columns: 1fr;
    }

    .level-list {
        grid-template-columns: repeat(3, 1fr);
        row-gap: 20px;
    }
}

@media(max-width: 380px) {
    .brand {
        font-size: 21px;
    }

    .header a {
        font-size: 11px;
    }

    .assessment-panel {
        padding: 15px;
    }
}
</style>
</head>

<body>

<header class="header">
    <div class="brand">Skill<span>Gap.</span></div>
    <a href="dashboard.jsp">← Back to Dashboard</a>
</header>

<main class="container">

    <div class="intro">
        <div class="eyebrow">STUDENT SKILL ANALYSIS</div>

        <h1>Assess Your <span>Technical Skills</span></h1>

        <p>
            Evaluate your current technical knowledge in four important
            areas. Your responses will help identify skill gaps and
            recommend suitable career paths and learning resources.
        </p>
    </div>

    <form action="SkillAssessmentServlet" method="post">

        <div class="assessment-panel">

            <div class="panel-heading">
                <h2>Your Skill Assessment</h2>
                <p>Select the level that best represents your current knowledge.</p>
            </div>

            <div class="skill-grid">

                <div class="skill-card">
                    <div class="skill-heading">
                        <div class="skill-icon">J</div>
                        <div>
                            <h3>Java Programming</h3>
                            <p>Core programming concepts</p>
                        </div>
                    </div>

                    <label class="field-label" for="java">
                        Select your Java proficiency
                    </label>

                    <select class="skill-select" id="java" name="java" required>
                        <option value="">Choose your level</option>
                        <option value="1">1 - Beginner</option>
                        <option value="2">2 - Basic</option>
                        <option value="3">3 - Intermediate</option>
                        <option value="4">4 - Advanced</option>
                        <option value="5">5 - Expert</option>
                    </select>
                </div>

                <div class="skill-card">
                    <div class="skill-heading">
                        <div class="skill-icon">PY</div>
                        <div>
                            <h3>Python Programming</h3>
                            <p>Python syntax and applications</p>
                        </div>
                    </div>

                    <label class="field-label" for="python">
                        Select your Python proficiency
                    </label>

                    <select class="skill-select" id="python" name="python" required>
                        <option value="">Choose your level</option>
                        <option value="1">1 - Beginner</option>
                        <option value="2">2 - Basic</option>
                        <option value="3">3 - Intermediate</option>
                        <option value="4">4 - Advanced</option>
                        <option value="5">5 - Expert</option>
                    </select>
                </div>

                <div class="skill-card">
                    <div class="skill-heading">
                        <div class="skill-icon">SQL</div>
                        <div>
                            <h3>Database & SQL</h3>
                            <p>Queries and database management</p>
                        </div>
                    </div>

                    <label class="field-label" for="sql">
                        Select your SQL proficiency
                    </label>

                    <select class="skill-select" id="sql" name="sql" required>
                        <option value="">Choose your level</option>
                        <option value="1">1 - Beginner</option>
                        <option value="2">2 - Basic</option>
                        <option value="3">3 - Intermediate</option>
                        <option value="4">4 - Advanced</option>
                        <option value="5">5 - Expert</option>
                    </select>
                </div>

                <div class="skill-card">
                    <div class="skill-heading">
                        <div class="skill-icon">&lt;/&gt;</div>
                        <div>
                            <h3>HTML & CSS</h3>
                            <p>Web design and development</p>
                        </div>
                    </div>

                    <label class="field-label" for="htmlcss">
                        Select your HTML & CSS proficiency
                    </label>

                    <select class="skill-select" id="htmlcss" name="htmlcss" required>
                        <option value="">Choose your level</option>
                        <option value="1">1 - Beginner</option>
                        <option value="2">2 - Basic</option>
                        <option value="3">3 - Intermediate</option>
                        <option value="4">4 - Advanced</option>
                        <option value="5">5 - Expert</option>
                    </select>
                </div>

            </div>

            <div class="level-guide">

                <h3>Understanding the Skill Levels</h3>

                <div class="level-list">

                    <div class="level-item">
                        <div class="level-number">1</div>
                        <p>Beginner</p>
                    </div>

                    <div class="level-item">
                        <div class="level-number">2</div>
                        <p>Basic</p>
                    </div>

                    <div class="level-item">
                        <div class="level-number">3</div>
                        <p>Intermediate</p>
                    </div>

                    <div class="level-item">
                        <div class="level-number">4</div>
                        <p>Advanced</p>
                    </div>

                    <div class="level-item">
                        <div class="level-number">5</div>
                        <p>Expert</p>
                    </div>

                </div>
            </div>

            <div class="submit-area">

                <button type="submit" class="submit-button">
                    Submit Assessment →
                </button>

                <p class="submit-note">
                    Please complete all four skill ratings before submitting.
                </p>

            </div>

        </div>

    </form>

</main>

<footer class="footer">
    Student Skill Gap Analysis and Learning Recommendation System
</footer>

</body>
</html>