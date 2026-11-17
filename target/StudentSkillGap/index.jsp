
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Student Skill Gap Analysis</title>

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
            color: #ffffff;
            min-height: 100vh;
        }

        .page {
            min-height: 100vh;
            position: relative;
            overflow: hidden;
            background:
                radial-gradient(ellipse at 15% 85%, rgba(45, 212, 191, 0.12), transparent 35%),
                radial-gradient(ellipse at 85% 15%, rgba(139, 92, 246, 0.23), transparent 40%),
                #090b1b;
        }

        .navbar {
            height: 85px;
            padding: 0 8%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid rgba(255,255,255,0.08);
            position: relative;
            z-index: 2;
        }

        .brand {
            font-family: 'Manrope', sans-serif;
            font-size: 19px;
            font-weight: 800;
            letter-spacing: 0.3px;
            color: #ffffff;
        }

        .brand span {
            color: #a78bfa;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 30px;
        }

        .nav-links a {
            color: #c3c5d8;
            text-decoration: none;
            font-size: 14px;
            transition: 0.3s;
        }

        .nav-links a:hover {
            color: #ffffff;
        }

        .nav-links .register {
            padding: 11px 21px;
            border: 1px solid #8b5cf6;
            border-radius: 9px;
            color: #ffffff;
        }

        .nav-links .register:hover {
            background: #8b5cf6;
        }

        .hero {
            min-height: calc(100vh - 85px);
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 60px 25px;
            position: relative;
            z-index: 1;
        }

        .hero-content {
            max-width: 850px;
        }

        .label {
            display: inline-block;
            padding: 9px 18px;
            border: 1px solid rgba(167, 139, 250, 0.35);
            background: rgba(139, 92, 246, 0.10);
            border-radius: 30px;
            color: #c4b5fd;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 30px;
        }

        h1 {
            font-family: 'Manrope', sans-serif;
            font-size: clamp(36px, 5.5vw, 65px);
            font-weight: 800;
            line-height: 1.2;
            letter-spacing: -2px;
            margin-bottom: 22px;
        }

        h1 span {
            background: linear-gradient(90deg, #a78bfa, #5eead4);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .description {
            max-width: 620px;
            margin: 0 auto;
            color: #a8acc5;
            font-size: 16px;
            line-height: 1.8;
        }

        .buttons {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 16px;
            margin-top: 38px;
        }

        .button {
            display: inline-block;
            padding: 15px 29px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 700;
            transition: 0.3s;
        }

        .primary {
            color: #ffffff;
            background: linear-gradient(110deg, #8b5cf6, #6950df);
            box-shadow: 0 8px 25px rgba(139, 92, 246, 0.25);
        }

        .primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(139, 92, 246, 0.4);
        }

        .secondary {
            color: #e5e7f5;
            border: 1px solid rgba(255,255,255,0.2);
        }

        .secondary:hover {
            background: rgba(255,255,255,0.08);
            transform: translateY(-3px);
        }

        .decoration {
            position: absolute;
            width: 420px;
            height: 420px;
            border: 1px solid rgba(167, 139, 250, 0.09);
            border-radius: 50%;
            top: 48%;
            left: 50%;
            transform: translate(-50%, -50%);
            pointer-events: none;
        }

        .decoration::before {
            content: "";
            position: absolute;
            inset: 35px;
            border: 1px solid rgba(45, 212, 191, 0.08);
            border-radius: 50%;
        }

        .footer {
            position: absolute;
            bottom: 20px;
            width: 100%;
            text-align: center;
            color: #70758f;
            font-size: 12px;
        }

        @media (max-width: 600px) {
            .navbar {
                padding: 0 5%;
                height: 72px;
            }

            .brand {
                font-size: 15px;
            }

            .nav-links {
                gap: 13px;
            }

            .nav-links a {
                font-size: 12px;
            }

            .nav-links .register {
                padding: 9px 12px;
            }

            h1 {
                letter-spacing: -1px;
            }

            .description {
                font-size: 14px;
            }

            .buttons {
                flex-direction: column;
            }

            .button {
                width: 190px;
            }

            .decoration {
                width: 280px;
                height: 280px;
            }
        }
    </style>
</head>

<body>
<div class="page">

    <nav class="navbar">
        <div class="brand">SKILL<span>PATH</span></div>

        <div class="nav-links">
            <a href="login.jsp">Login</a>
            <a href="register.jsp" class="register">Register</a>
        </div>
    </nav>

    <div class="decoration"></div>

    <main class="hero">
        <div class="hero-content">

            <div class="label">Your Learning Journey Starts Here</div>

            <h1>
                Student Skill Gap Analysis<br>
                <span>and Learning Recommendation System</span>
            </h1>

            <p class="description">
                Identify your potential. Discover your career path.
                Build the skills that move you forward.
            </p>

            <div class="buttons">
                <a href="register.jsp" class="button primary">
                    Get Started
                </a>

                <a href="login.jsp" class="button secondary">
                    Login
                </a>
            </div>

        </div>
    </main>

    <footer class="footer">
        Learn. Improve. Achieve.
    </footer>

</div>
</body>
</html>
