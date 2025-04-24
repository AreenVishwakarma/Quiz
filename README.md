Here’s a detailed `README.md` file for your Quiz Web Application using JSP and Servlets. It covers both admin and student functionalities:

---

# 🧠 Quiz Web Application (JSP + Servlet)

A web-based Quiz Management System built using **JSP**, **Servlets**, and **MySQL**. The application provides separate login access for **Admin** and **Student** users. It allows **Admins** to manage quizzes and students, while **Students** can take daily or weekly quizzes and view their results.

---

## 🚀 Features

### 👨‍🏫 Admin Panel
- **Login as Admin**
- **Add Quiz Questions** (MCQs)
- **View Results of All Students**
- **Delete a Student Record**

### 👨‍🎓 Student Panel
- **Login as Student**
- **Choose Quiz Type**
  - Daily Quiz
  - Weekly Quiz
- **Answer MCQs and Submit**
- **View Individual Quiz Results**

---

## 🔧 Technologies Used
- **Frontend:** HTML, CSS, JSP
- **Backend:** Java Servlet
- **Database:** MySQL
- **Server:** Apache Tomcat

---

## 🔐 User Roles

### Admin
- Access the admin dashboard via "Admin Login".
- Add quiz questions with options and correct answers.
- View results submitted by all students.
- Delete any student record.

### Student
- Login with student credentials via "Student Login".
- Choose a quiz type (Daily/Weekly).
- Attempt MCQ-based quiz.
- Submit and instantly view quiz result.
- Can also view a history of past quiz results.

---

## 📁 Project Structure

```
QuizApp/
│
├── WebContent/
│   ├── index.jsp
│   ├── login.jsp
│   ├── adminDashboard.jsp
│   ├── studentDashboard.jsp
│   ├── quizForm.jsp
│   ├── result.jsp
│   └── css/
│       └── style.css
│
├── src/
│   ├── servlet/
│   │   ├── AdminLoginServlet.java
│   │   ├── StudentLoginServlet.java
│   │   ├── AddQuestionServlet.java
│   │   ├── SubmitQuizServlet.java
│   │   ├── ViewResultsServlet.java
│   │   └── DeleteStudentServlet.java
│
├── database/
│   └── quiz_schema.sql
│
└── README.md
```

---

## 🗃️ Database Schema (MySQL)

### `users`
```sql
id INT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(50),
password VARCHAR(50),
role ENUM('admin', 'student')
```

### `questions`
```sql
id INT AUTO_INCREMENT PRIMARY KEY,
question TEXT,
option_a VARCHAR(255),
option_b VARCHAR(255),
option_c VARCHAR(255),
option_d VARCHAR(255),
correct_option CHAR(1),
quiz_type ENUM('daily', 'weekly')
```

### `results`
```sql
id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT,
quiz_type ENUM('daily', 'weekly'),
score INT,
date_taken DATETIME
```

---

## 🛠️ How to Run

1. Clone or download the repository.
2. Import the project into Eclipse/NetBeans.
3. Setup a MySQL database using `quiz_schema.sql`.
4. Update your DB credentials in `DBConnection.java`.
5. Deploy on Apache Tomcat.
6. Access via `http://localhost:8080/QuizApp`.

---

## 📝 Notes
- Admin and Student login credentials should be pre-inserted or created via the database.
- Questions are categorized into Daily and Weekly quizzes.
- Results are stored with timestamps and quiz type for accurate tracking.

---

## 📬 Feedback

Feel free to report issues or suggest improvements!

---

Let me know if you want to include screenshots, sample data inserts, or more advanced features like pagination or timer for the quiz.
