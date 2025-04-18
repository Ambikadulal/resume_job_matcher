import 'package:flutter/material.dart';

class ResumeInputScreen extends StatefulWidget {
  const ResumeInputScreen({super.key});

  @override
  State<ResumeInputScreen> createState() => _ResumeInputScreenState();
}

class _ResumeInputScreenState extends State<ResumeInputScreen> {
  final TextEditingController _resumeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Your Resume')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: TextFormField(
                controller: _resumeController,
                maxLines: null, // Allows for multiline input
                expands:
                    true, // Makes the text field expand to fill available space
                decoration: InputDecoration(
                  labelText: 'Paste your resume text here',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String resumeText = _resumeController.text;
                print('Resume Text: $resumeText'); // For testing
                Navigator.pushNamed(
                  context,
                  '/jobDescription',
                  arguments: resumeText, // Pass the resume text as arguments
                );
              },
              child: Text('Next: Enter Job Description'),
            ),
          ],
        ),
      ),
    );
  }
}
