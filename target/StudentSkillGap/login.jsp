
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if (session.getAttribute("student") != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Login | SkillPath</title>

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
            display: flex;
            background: #080d1c;
        }

        .left-panel {
            width: 50%;
            background:
                radial-gradient(circle at 15% 15%, rgba(137,108,255,0.24), transparent 40%),
                linear-gradient(145deg, #10172e, #242052 65%, #123c43);
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 70px;
            position: relative;
            overflow: hidden;
        }

        .left-panel::after {
            content: "";
            position: absolute;
            width: 320px;
            height: 320px;
            border: 1px solid rgba(255,255,255,0.15);
            border-radius: 50%;
            right: -110px;
            bottom: -100px;
            box-shadow:
                0 0 0 35px rgba(255,255,255,0.04),
                0 0 0 70px rgba(255,255,255,0.03);
        }

        .brand {
            position: absolute;
            top: 38px;
            left: 55px;
            font-size: 25px;
            font-weight: 800;
            letter-spacing: -1px;
        }

        .brand span {
            color: #a99aff;
        }

        .left-content {
            position: relative;
            z-index: 1;
            max-width: 480px;
        }

        .tag {
            display: inline-block;
            background: rgba(255,255,255,0.10);
            border: 1px solid rgba(255,255,255,0.12);
            padding: 9px 15px;
            border-radius: 20px;
            font-size: 11px;
            letter-spacing: 1.5px;
            margin-bottom: 25px;
            color: #d2caff;
        }

        .left-content h1 {
            font-size: 43px;
            line-height: 1.25;
            letter-spacing: -1.5px;
            margin-bottom: 20px;
        }

        .left-content p {
            color: #c2c9e2;
            font-size: 15px;
            line-height: 1.9;
        }

        .right-panel {
            width: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 35px;
            background:
                radial-gradient(ellipse at 90% 10%, rgba(103,78,200,0.12), transparent 40%),
                #080d1c;
        }

        .login-card {
            width: 100%;
            max-width: 420px;
            background: rgba(20,27,49,0.92);
            padding: 43px;
            border-radius: 20px;
            border: 1px solid rgba(255,255,255,0.10);
            box-shadow: 0 20px 55px rgba(0,0,0,0.25);
        }

        .login-card h2 {
            font-size: 29px;
            color: #f5f5ff;
            margin-bottom: 9px;
        }

        .subtitle {
            color: #969db6;
            font-size: 13px;
            margin-bottom: 32px;
            line-height: 1.7;
        }

        label {
            display: block;
            color: #dce0f2;
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 9px;
        }

        .input-field {
            width: 100%;
            padding: 14px 15px;
            border: 1px solid #303953;
            border-radius: 9px;
            font-size: 14px;
            outline: none;
            margin-bottom: 22px;
            background: #111a30;
            color: white;
            transition: 0.25s;
        }

        .input-field::placeholder {
            color: #75809d;
        }

        .input-field:focus {
            border-color: #9280f4;
            background: #151e36;
            box-shadow: 0 0 0 3px rgba(146,128,244,0.13);
        }

        .password-wrapper {
            position: relative;
        }

        .password-wrapper .input-field {
            padding-right: 70px;
        }

        .show-password {
            position: absolute;
            right: 13px;
            top: 13px;
            border: none;
            background: transparent;
            color: #a99aff;
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
            width: auto;
            padding: 5px;
        }

        .show-password:hover {
            color: #d2caff;
        }

        .login-btn {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(100deg, #8068ed, #28b9b0);
            color: white;
            font-size: 15px;
            font-weight: 800;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: all 0.25s ease;
            box-shadow: 0 7px 20px rgba(128,104,237,0.20);
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(128,104,237,0.35);
            filter: brightness(1.08);
        }

        .login-btn:active {
            transform: scale(0.98);
        }

        .login-btn:disabled {
            opacity: 0.75;
            cursor: wait;
            transform: none;
            filter: none;
        }

        .btn-arrow {
            font-size: 20px;
            transition: transform 0.25s ease;
        }

        .login-btn:hover .btn-arrow {
            transform: translateX(5px);
        }

        .spinner {
            width: 17px;
            height: 17px;
            border: 2px solid rgba(255,255,255,0.35);
            border-top-color: white;
            border-radius: 50%;
            animation: spin 0.7s linear infinite;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }

        .error {
            background: rgba(220,60,70,0.12);
            color: #ff9a9f;
            border: 1px solid rgba(255,100,110,0.25);
            padding: 12px;
            border-radius: 8px;
            font-size: 13px;
            margin-bottom: 18px;
        }

        .register-text {
            text-align: center;
            color: #929bb7;
            font-size: 13px;
            margin-top: 25px;
        }

        .register-text a {
            color: #a99aff;
            font-weight: 700;
            text-decoration: none;
        }

        .register-text a:hover {
            color: #c9bdff;
            text-decoration: underline;
        }

        @media(max-width: 800px) {
            body {
                flex-direction: column;
            }

            .left-panel {
                width: 100%;
                min-height: 260px;
                padding: 85px 30px 35px;
            }

            .brand {
                top: 25px;
                left: 30px;
            }

            .left-content h1 {
                font-size: 30px;
            }

            .right-panel {
                width: 100%;
                padding: 30px 18px;
            }

            .login-card {
                padding: 30px 24px;
            }
        }
    </style>
</head>

<body>

<section class="left-panel">

    <div class="brand">SKILL<span>PATH</span></div>

    <div class="left-content">

        <div class="tag">STUDENT SKILL DEVELOPMENT</div>

        <h1>Build Your Skills.<br>Shape Your Future.</h1>

        <p>
            Discover your strengths, identify skill gaps
            and move towards your dream career with
            personalized learning recommendations.
        </p>

    </div>

</section>

<section class="right-panel">

    <div class="login-card">

        <h2>Welcome Back!</h2>

        <p class="subtitle">
            Login to continue your learning journey.
        </p>

        <% if ("invalid".equals(request.getParameter("error"))) { %>
            <div class="error">
                Invalid email or password. Please try again.
            </div>
        <% } %>

        <form action="LoginServlet" method="post" id="loginForm">

            <label for="email">Email Address</label>

            <input
                class="input-field"
                type="email"
                id="email"
                name="email"
                placeholder="Enter your email"
                autocomplete="username"
                required>

            <label for="password">Password</label>

            <div class="password-wrapper">

                <input
                    class="input-field"
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Enter your password"
                    autocomplete="current-password"
                    required>

                <button
                    type="button"
                    class="show-password"
                    id="showPasswordBtn"
                    onclick="togglePassword()">
                    Show
                </button>

            </div>

            <button type="submit" class="login-btn" id="loginBtn">
                <span id="btnText">Login</span>
                <span class="btn-arrow" id="btnArrow">→</span>
            </button>

        </form>

        <div class="register-text">
            Don't have an account?
            <a href="register.jsp">Create an account</a>
        </div>

    </div>

</section>

<script>
    function togglePassword() {
        const password = document.getElementById("password");
        const button = document.getElementById("showPasswordBtn");

        if (password.type === "password") {
            password.type = "text";
            button.textContent = "Hide";
        } else {
            password.type = "password";
            button.textContent = "Show";
        }
    }

    const loginForm = document.getElementById("loginForm");
    const loginBtn = document.getElementById("loginBtn");
    const btnText = document.getElementById("btnText");
    const btnArrow = document.getElementById("btnArrow");

    loginForm.addEventListener("submit", function(event) {

        if (!loginForm.checkValidity()) {
            return;
        }

        if (loginBtn.disabled) {
            event.preventDefault();
            return;
        }

        loginBtn.disabled = true;
        btnText.textContent = "Logging in...";
        btnArrow.className = "spinner";
        btnArrow.textContent = "";
    });
</script>

</body>
</html>
