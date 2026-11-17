# Student Skill Gap Analysis and Learning Recommendation System

A Java-based web application designed to help students identify the difference between their current skills and the skills required for their learning or career goals. The system is intended to support skill assessment and provide learning recommendations to help students plan their improvement.

## Project Overview

Students may find it difficult to understand which technical skills they need to improve for a particular career path. This project aims to provide a structured way to record skills, analyse skill gaps, and guide students towards relevant learning resources.

## Technology Stack

The repository is configured with the following technologies and libraries:

- **Programming language:** Java 17
- **Web technology:** Jakarta Servlets (Jakarta Servlet API 6.0)
- **Build tool:** Apache Maven
- **Packaging:** WAR (Web Application Archive)
- **Servlet container:** Apache Tomcat 10.1 or another Jakarta Servlet 6.0-compatible server
- **Database library:** H2 Database
- **Password hashing library:** jBCrypt

> The current `pom.xml` specifies H2 Database. Update this section if the application is later configured to use a different database.

## Prerequisites

Install the following before running the project:

1. Java Development Kit (JDK) 17
2. Apache Maven
3. Apache Tomcat 10.1
4. Git (to clone the repository)

Check the installations in a terminal:

```bash
java -version
mvn -version
```

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/BMSharada/StudentSkillGap.git
```

### 2. Open the project folder

```bash
cd StudentSkillGap
```

Open this folder in your preferred IDE, such as Visual Studio Code.

### 3. Build the project

Run the following command from the folder containing `pom.xml`:

```bash
mvn clean package
```

Maven builds the web application and creates the WAR file:

```text
target/StudentSkillGap.war
```

### 4. Deploy to Apache Tomcat

1. Make sure Tomcat is configured and running.
2. Copy `target/StudentSkillGap.war` into Tomcat's `webapps` folder.
3. Start or restart Tomcat.
4. Open the application in a browser. If Tomcat uses port `8080`, visit:

```text
http://localhost:8080/StudentSkillGap/
```

If you configured Tomcat to use a different port, replace `8080` with that port.

## Project Structure

The repository currently includes a Maven project descriptor and a Java web application source directory.

```text
StudentSkillGap/
├── src/
│   └── main/
├── target/                 # Generated build output (created by Maven)
└── pom.xml                 # Maven configuration
```

The source folders and files under `src/main` may be expanded as the application is developed.

## Main Objective

The objective of this project is to provide a system that can:

- Maintain student skill information.
- Compare a student's existing skills with skills needed for a selected goal.
- Identify missing or weaker skills.
- Suggest suitable learning topics or resources.
- Help students make a structured learning plan.

The exact modules and available features depend on the implementation in the source code.

## Build Command

To clean and rebuild the application:

```bash
mvn clean package
```

## Troubleshooting

- **`mvn` is not recognized:** Install Apache Maven and add its `bin` directory to the Windows `Path` environment variable. Reopen the terminal.
- **Java version error:** Confirm that JDK 17 is installed and that `JAVA_HOME` points to the JDK 17 folder.
- **Port 8080 is already in use:** Change the Tomcat connector port in `conf/server.xml`, then use the updated port in the browser URL.
- **Application not found:** Confirm that the WAR file was copied into Tomcat's `webapps` folder and check Tomcat's logs for deployment errors.

## Author

**Budimatha Sharada**

## Repository

[Student Skill Gap Analysis and Learning Recommendation System](https://github.com/BMSharada/StudentSkillGap)
