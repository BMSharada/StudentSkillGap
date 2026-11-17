<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account | SkillGap</title>

    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700;800&family=Manrope:wght@500;600;700;800&display=swap" rel="stylesheet">

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
            align-items: center;
            justify-content: center;
            padding: 35px;
            background:
                radial-gradient(circle at 15% 20%, rgba(124, 92, 255, 0.18), transparent 35%),
                radial-gradient(circle at 85% 80%, rgba(32, 211, 190, 0.10), transparent 35%),
                #090e20;
            color: #fff;
        }

        .container {
            width: 100%;
            max-width: 1050px;
            min-height: 620px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            overflow: hidden;
            border: 1px solid rgba(255,255,255,0.09);
            border-radius: 24px;
            background: rgba(17, 25, 48, 0.92);
            box-shadow: 0 25px 80px rgba(0,0,0,0.35);
        }

        .left-panel {
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 65px;
            overflow: hidden;
            background: linear-gradient(145deg, #171d3b, #252052 65%, #153c4a);
        }

        .left-panel::before,
        .left-panel::after {
            content: "";
            position: absolute;
            border: 1px solid rgba(255,255,255,0.08);
            border-radius: 50%;
        }

        .left-panel::before {
            width: 360px;
            height: 360px;
            right: -170px;
            top: -100px;
        }

        .left-panel::after {
            width: 260px;
            height: 260px;
            right: -100px;
            bottom: -100px;
        }

        .brand {
            position: absolute;
            top: 35px;
            left: 45px;
            font-family: 'Manrope', sans-serif;
            font-size: 24px;
            font-weight: 800;
            letter-spacing: 1px;
            z-index: 1;
        }

        .brand span {
            color: #9b8aff;
        }

        .left-content {
            position: relative;
            z-index: 1;
            max-width: 420px;
        }

        .tag {
            display: inline-block;
            padding: 9px 15px;
            margin-bottom: 25px;
            border: 1px solid rgba(167,150,255,0.25);
            border-radius: 30px;
            background: rgba(151,130,255,0.12);
            color: #c4b8ff;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1.5px;
        }

        .left-content h1 {
            margin-bottom: 22px;
            font-family: 'Manrope', sans-serif;
            font-size: 39px;
            line-height: 1.3;
            font-weight: 800;
        }

        .left-content h1 span {
            color: #a99aff;
        }

        .left-content p {
            color: #b9c3dc;
            font-size: 14px;
            line-height: 1.9;
        }

        .right-panel {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 45px;
        }

        .register-card {
            width: 100%;
            max-width: 390px;
        }

        .register-card h2 {
            margin-bottom: 9px;
            font-family: 'Manrope', sans-serif;
            font-size: 29px;
            font-weight: 800;
        }

        .subtitle {
            margin-bottom: 30px;
            color: #929db8;
            font-size: 13px;
        }

        .field {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #dce3f5;
            font-size: 12px;
            font-weight: 700;
        }

        .input-wrap {
            position: relative;
        }

        input {
            width: 100%;
            height: 47px;
            padding: 0 14px;
            border: 1px solid #303b5b;
            border-radius: 9px;
            outline: none;
            background: #111a32;
            color: #fff;
            font-size: 13px;
            transition: 0.25s;
        }

        input::placeholder {
            color: #697590;
        }

        input:focus {
            border-color: #9280ff;
            box-shadow: 0 0 0 3px rgba(146,128,255,0.12);
        }

        .password-input {
            padding-right: 48px;
        }

        .toggle-password {
            position: absolute;
            top: 50%;
            right: 13px;
            transform: translateY(-50%);
            border: none;
            background: transparent;
            color: #9ca8c4;
            cursor: pointer;
            font-size: 18px;
            padding: 4px;
        }

        .toggle-password:hover {
            color: #b9aaff;
        }

        .error {
            display: none;
            margin-top: 7px;
            color: #ff8585;
            font-size: 12px;
        }

        .server-error {
            display: block;
            margin: 0 0 15px;
            padding: 10px 12px;
            border: 1px solid rgba(255,100,100,0.25);
            border-radius: 8px;
            background: rgba(255,80,80,0.08);
            color: #ff9999;
            font-size: 12px;
        }

        .submit-btn {
            width: 100%;
            height: 49px;
            margin-top: 8px;
            border: none;
            border-radius: 9px;
            background: linear-gradient(100deg, #7659ed, #9278ff);
            color: white;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.25s;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 9px 25px rgba(126,96,255,0.25);
        }

        .submit-btn:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }

        .login-text {
            margin-top: 24px;
            text-align: center;
            color: #929db8;
            font-size: 13px;
        }

        .login-text a {
            color: #aa9aff;
            font-weight: 700;
            text-decoration: none;
        }

        .login-text a:hover {
            color: #c4baff;
        }

        /* Success popup */

        .modal-overlay {
            position: fixed;
            inset: 0;
            z-index: 10;
            display: none;
            align-items: center;
            justify-content: center;
            padding: 20px;
            background: rgba(3,7,18,0.82);
            backdrop-filter: blur(7px);
        }

        .modal-overlay.show {
            display: flex;
        }

        .success-modal {
            width: 100%;
            max-width: 390px;
            padding: 38px 30px;
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 20px;
            background: #151e38;
            text-align: center;
            box-shadow: 0 25px 80px rgba(0,0,0,0.5);
            animation: popup 0.3s ease;
        }

        @keyframes popup {
            from {
                opacity: 0;
                transform: translateY(15px) scale(0.96);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .success-icon {
            width: 65px;
            height: 65px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            border-radius: 50%;
            background: rgba(37,211,160,0.13);
            color: #35d5a4;
            font-size: 32px;
        }

        .success-modal h2 {
            margin-bottom: 10px;
            font-family: 'Manrope', sans-serif;
            font-size: 23px;
        }

        .success-modal p {
            margin-bottom: 25px;
            color: #aab5cf;
            font-size: 13px;
            line-height: 1.7;
        }

        .login-btn {
            display: block;
            width: 100%;
            padding: 13px;
            border-radius: 9px;
            background: linear-gradient(100deg, #7659ed, #9278ff);
            color: white;
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
            transition: 0.25s;
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(126,96,255,0.25);
        }

        @media(max-width: 800px) {
            body {
                padding: 18px;
            }

            .container {
                grid-template-columns: 1fr;
            }

            .left-panel {
                min-height: 270px;
                padding: 85px 30px 35px;
            }

            .brand {
                top: 25px;
                left: 30px;
            }

            .left-content h1 {
                font-size: 29px;
            }

            .right-panel {
                padding: 35px 25px;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <section class="left-panel">

        <div class="brand">SKILL<span>GAP.</span></div>

        <div class="left-content">
            <div class="tag">START YOUR LEARNING JOURNEY</div>

            <h1>Your Future Starts With <span>One Step.</span></h1>

            <p>
                Create your account to assess your technical skills,
                discover your career opportunities and receive
                personalized learning recommendations.
            </p>
        </div>

    </section>

    <section class="right-panel">

        <div class="register-card">

            <h2>Create Account</h2>

            <p class="subtitle">
                Join SkillGap and start improving your skills.
            </p>

            <% if ("1".equals(request.getParameter("error"))) { %>

                <div class="server-error">
                    Registration failed. Please try again.
                </div>

            <% } else if ("exists".equals(request.getParameter("error"))) { %>

                <div class="server-error">
                    This email is already registered. Please login.
                </div>

            <% } else if ("password".equals(request.getParameter("error"))) { %>

                <div class="server-error">
                    Passwords do not match. Please try again.
                </div>

            <% } %>

            <form id="registerForm" action="RegisterServlet" method="post">

                <div class="field">
                    <label for="name">Full Name</label>

                    <input type="text"
                           id="name"
                           name="name"
                           placeholder="Enter your full name"
                           required
                           autocomplete="name">
                </div>

                <div class="field">
                    <label for="email">Email Address</label>

                    <input type="email"
                           id="email"
                           name="email"
                           placeholder="Enter your email address"
                           required
                           autocomplete="email">
                </div>

                <div class="field">
                    <label for="password">Password</label>

                    <div class="input-wrap">

                        <input type="password"
                               id="password"
                               name="password"
                               class="password-input"
                               placeholder="Create a password"
                               required
                               minlength="6"
                               autocomplete="new-password">

                        <button type="button"
                                class="toggle-password"
                                onclick="togglePassword('password', this)"
                                aria-label="Show password">◉</button>

                    </div>
                </div>

                <div class="field">
                    <label for="confirmPassword">Confirm Password</label>

                    <div class="input-wrap">

                        <input type="password"
                               id="confirmPassword"
                               name="confirmPassword"
                               class="password-input"
                               placeholder="Re-enter your password"
                               required
                               minlength="6"
                               autocomplete="new-password">

                        <button type="button"
                                class="toggle-password"
                                onclick="togglePassword('confirmPassword', this)"
                                aria-label="Show confirm password">◉</button>

                    </div>

                    <p class="error" id="passwordError">
                        Passwords do not match.
                    </p>
                </div>

                <button type="submit"
                        class="submit-btn"
                        id="submitBtn">
                    Create My Account &rarr;
                </button>

            </form>

            <div class="login-text">
                Already have an account?
                <a href="login.jsp">Login</a>
            </div>

        </div>

    </section>

</div>

<!-- Registration success popup -->

<div class="modal-overlay" id="successModal">

    <div class="success-modal">

        <div class="success-icon">✓</div>

        <h2>Registration Successful!</h2>

        <p>
            Your account has been created successfully.
            You can now login and start your learning journey.
        </p>

        <a href="login.jsp" class="login-btn">
            Go to Login &rarr;
        </a>

    </div>

</div>

<script>

    const form = document.getElementById("registerForm");
    const password = document.getElementById("password");
    const confirmPassword = document.getElementById("confirmPassword");
    const passwordError = document.getElementById("passwordError");
    const submitBtn = document.getElementById("submitBtn");

    // Show or hide password

    function togglePassword(id, button) {

        const field = document.getElementById(id);

        if (field.type === "password") {

            field.type = "text";
            button.textContent = "◎";
            button.setAttribute("aria-label", "Hide password");

        } else {

            field.type = "password";
            button.textContent = "◉";
            button.setAttribute("aria-label", "Show password");

        }
    }

    // Validate registration form

    form.addEventListener("submit", function(event) {

        if (password.value !== confirmPassword.value) {

            event.preventDefault();

            passwordError.style.display = "block";
            confirmPassword.focus();

            return;
        }

        passwordError.style.display = "none";

        if (!form.checkValidity()) {

            event.preventDefault();
            form.reportValidity();

            return;
        }

        submitBtn.disabled = true;
        submitBtn.textContent = "Creating Account...";

    });

    // Hide password error while correcting input

    confirmPassword.addEventListener("input", function() {

        if (password.value === confirmPassword.value) {
            passwordError.style.display = "none";
        }

    });

    password.addEventListener("input", function() {

        if (password.value === confirmPassword.value) {
            passwordError.style.display = "none";
        }

    });

    // Show popup only after successful servlet registration

    const urlParams = new URLSearchParams(window.location.search);

    if (urlParams.get("registered") === "1") {

        document.getElementById("successModal")
                .classList.add("show");

        window.history.replaceState(
            {},
            document.title,
            window.location.pathname
        );
    }

</script>

</body>
</html>
