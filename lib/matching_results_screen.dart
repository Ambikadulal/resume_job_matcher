import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:resume_job_matcher/main.dart';

class MatchingResultsScreen extends StatefulWidget {
  final String resumeText;
  final String jobDescriptionText;
  const MatchingResultsScreen({
    super.key,
    required this.resumeText,
    required this.jobDescriptionText,
  });

  @override
  State<MatchingResultsScreen> createState() => _MatchingResultsScreenState();
}

class _MatchingResultsScreenState extends State<MatchingResultsScreen> {
  String? _matchResult;
  bool _isLoading = false;

  final model = GenerativeModel(model: 'MODEL_NAME', apiKey: apiKey);

  @override
  void initState() {
    super.initState();
    _performMatch();
  }

  Future<void> _performMatch() async {
    setState(() {
      _isLoading = true;
      _matchResult = 'Processing...';
    });

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      ); // Changed model name
      final prompt = '''
      Compare the following resume and job description and identify the key matching points.
      Highlight the skills, experiences, and keywords that are present in both.
      Also, provide a brief summary of the overall match and a potential match score (out of 100).

      Resume:
      ${widget.resumeText}

      Job Description:
      ${widget.jobDescriptionText}
    ''';

      final response = await model.generateContent([Content.text(prompt)]);

      setState(() {
        _isLoading = false;
        _matchResult = response.text;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _matchResult = 'Error: ${e.toString()}';
        print(_matchResult);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Matching Results')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  child: Text(_matchResult ?? 'No results.'),
                ),
      ),
    );
  }
}
