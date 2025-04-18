import 'package:flutter/material.dart';
import 'package:resume_job_matcher/matching_results_screen.dart';

class JobDescriptionInputScreen extends StatefulWidget {
  const JobDescriptionInputScreen({super.key});

  @override
  State<JobDescriptionInputScreen> createState() =>
      _JobDescriptionInputScreenState();
}

class _JobDescriptionInputScreenState extends State<JobDescriptionInputScreen> {
  final TextEditingController _jobDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Job Description')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: TextFormField(
                controller: _jobDescriptionController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  labelText: 'Paste the job description text here',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String jobDescriptionText = _jobDescriptionController.text;
                // Get the resume text from the previous screen's navigation
                final resumeText =
                    ModalRoute.of(context)?.settings.arguments as String?;

                if (resumeText != null && jobDescriptionText.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => MatchingResultsScreen(
                            resumeText: resumeText,
                            jobDescriptionText: jobDescriptionText,
                          ),
                      settings: RouteSettings(
                        arguments:
                            resumeText, // Pass resume text again if needed later
                      ),
                    ),
                  );
                } else {
                  // Handle the case where resume text is null or job description is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Please enter both resume and job description.',
                      ),
                    ),
                  );
                }
              },
              child: Text('Show Match'),
            ),
          ],
        ),
      ),
    );
  }
}
