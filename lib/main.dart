import 'package:flutter/material.dart';
import 'package:resume_job_matcher/job_description_input_screen.dart';
import 'package:resume_job_matcher/resume_inout_screen.dart';

const String apiKey = 'YOUR_API_KEY_HERE'; // Replace with your actual API key

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume to Job Matcher',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:
          ResumeInputScreen(), // Set the resume input screen as the starting point
      routes: {'/jobDescription': (context) => JobDescriptionInputScreen()},
    );
  }
}



// Job Description:

// Job Title: Software Engineer

// Company: Tech Innovations Inc.

// Location: Mountain View, CA

// Job Summary:
// Tech Innovations Inc. is seeking a talented and passionate Software Engineer to join our dynamic development team. The ideal candidate will have a strong background in designing, developing, and testing software applications. You will be involved in the full software development lifecycle, from requirements gathering to deployment and maintenance.

// Responsibilities:
// - Design, develop, and maintain software applications using Java and Python.
// - Write clean, well-documented, and efficient code.
// - Participate in code reviews to ensure code quality.
// - Collaborate with cross-functional teams including product managers and designers.
// - Troubleshoot and debug software defects.
// - Contribute to the improvement of our development processes.
// - Stay up-to-date with the latest technologies and trends in software development.

// Qualifications:
// - Bachelor's degree in Computer Science or a related field.
// - 3+ years of professional experience in software development.
// - Strong proficiency in Java and Python.
// - Experience with relational databases (e.g., MySQL, PostgreSQL).
// - Familiarity with version control systems (e.g., Git).
// - Excellent problem-solving and communication skills.
// - Experience with Agile development methodologies is a plus.


// Resume
// John Doe
// (123) 456-7890 | john.doe@email.com | LinkedIn Profile URL

// Summary
// A highly motivated and results-oriented Software Engineer with over four years of experience in designing, developing, and testing software solutions. Proven ability to write clean and efficient code in Java and Python, and to collaborate effectively within Agile teams.

// Skills
// - Programming Languages: Java (Proficient), Python (Expert), C++ (Familiar)
// - Databases: MySQL, PostgreSQL, MongoDB (Basic)
// - Version Control: Git, SVN
// - Methodologies: Agile (Scrum, Kanban), Waterfall
// - Operating Systems: Linux, Windows, macOS
// - Other: Problem-solving, Communication (Excellent), Teamwork

// Experience
// Software Engineer | Acme Software Corp. | Anytown, USA | 2020 - Present
// - Developed and maintained several key features for the company's flagship product using Java and Python.
// - Participated in daily Scrum meetings and contributed to sprint planning.
// - Conducted code reviews to ensure adherence to coding standards.
// - Collaborated with product managers and designers to define requirements.
// - Successfully debugged and resolved critical software issues.

// Junior Software Developer | Beta Technologies Inc. | Someville, USA | 2018 - 2020
// - Assisted senior developers in designing and implementing software modules.
// - Wrote unit and integration tests.
// - Gained experience with the full software development lifecycle.

// Education
// Bachelor of Science in Computer Science | University of Tech | Techville, USA | 2014 - 2018

// Awards and Recognition
// - Employee of the Month (Acme Software Corp.) - June 2022