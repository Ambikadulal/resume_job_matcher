// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:resume_job_matcher/main.dart';

// class MatchingResultsScreen extends StatefulWidget {
//   final String resumeText;
//   final String jobDescriptionText;
//   const MatchingResultsScreen({
//     super.key,
//     required this.resumeText,
//     required this.jobDescriptionText,
//   });

//   @override
//   State<MatchingResultsScreen> createState() => _MatchingResultsScreenState();
// }

// class _MatchingResultsScreenState extends State<MatchingResultsScreen> {
//   String? _matchResult;
//   bool _isLoading = false;

//   final model = GenerativeModel(model: 'MODEL_NAME', apiKey: apiKey);

//   @override
//   void initState() {
//     super.initState();
//     _performMatch();
//   }

//   Future<void> _performMatch() async {
//     setState(() {
//       _isLoading = true;
//       _matchResult = 'Processing...';
//     });

//     try {
//       final model = GenerativeModel(
//         model: 'gemini-1.5-flash',
//         apiKey: apiKey,
//       ); // Changed model name
//       final prompt = '''
//       Compare the following resume and job description and identify the key matching points.
//       Highlight the skills, experiences, and keywords that are present in both.
//       Also, provide a brief summary of the overall match and a potential match score (out of 100).

//       Resume:
//       ${widget.resumeText}

//       Job Description:
//       ${widget.jobDescriptionText}
//     ''';

//       final response = await model.generateContent([Content.text(prompt)]);

//       setState(() {
//         _isLoading = false;
//         _matchResult = response.text;
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _matchResult = 'Error: ${e.toString()}';
//         debugPrint(_matchResult);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Matching Results')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child:
//             _isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : SingleChildScrollView(
//                   child: Text(_matchResult ?? 'No results.'),
//                 ),
//       ),
//     );
//   }
// }





import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
  MatchResult? _matchData;
  String? _matchResult;
  bool _isLoading = false;

  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: apiKey,
  );

  @override
  void initState() {
    super.initState();
    _performMatch();
  }

  Future<void> _performMatch() async {
    setState(() {
      _isLoading = true;
    });

    final prompt = '''
Compare the following resume and job description.

Return a JSON with:
- "match_score": number (out of 100),
- "summary": brief summary text,
- "matched_skills": list of strings,
- "matched_experience": list of strings,
- "matched_keywords": list of strings

Resume:
${widget.resumeText}

Job Description:
${widget.jobDescriptionText}
''';

    try {
      final response = await model.generateContent([Content.text(prompt)]);
      final rawText = response.text ?? '';

      final jsonStart = rawText.indexOf('{');
      final jsonEnd = rawText.lastIndexOf('}');
      final jsonString = rawText.substring(jsonStart, jsonEnd + 1);

      final decoded = json.decode(jsonString);
      final matchResult = MatchResult.fromJson(decoded);

      setState(() {
        _matchData = matchResult;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _matchResult = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Matching Results')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _matchData == null
                ? Text(_matchResult ?? 'No results found.')
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Summary', style: theme.titleMedium),
                        const SizedBox(height: 8),
                        Text(_matchData!.summary),
                        const SizedBox(height: 24),

                        Text('Match Score', style: theme.titleMedium),
                        const SizedBox(height: 10),
                        Center(
                          child: CircularPercentIndicator(
                            radius: 60.0,
                            lineWidth: 10.0,
                            percent: _matchData!.matchScore / 100,
                            center: Text(
                              '${_matchData!.matchScore}%',
                              style: theme.titleLarge,
                            ),
                            progressColor: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 24),

                        Text('Matched Skills', style: theme.titleMedium),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: _matchData!.matchedSkills
                              .map((skill) => Chip(label: Text(skill)))
                              .toList(),
                        ),
                        const SizedBox(height: 24),

                        Text('Matched Experience', style: theme.titleMedium),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: _matchData!.matchedExperience
                              .map((exp) => Chip(label: Text(exp)))
                              .toList(),
                        ),
                        const SizedBox(height: 24),

                        Text('Matched Keywords', style: theme.titleMedium),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: _matchData!.matchedKeywords
                              .map((kw) => Chip(label: Text(kw)))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}

// --- Model class to parse JSON ---

class MatchResult {
  final int matchScore;
  final String summary;
  final List<String> matchedSkills;
  final List<String> matchedExperience;
  final List<String> matchedKeywords;

  MatchResult({
    required this.matchScore,
    required this.summary,
    required this.matchedSkills,
    required this.matchedExperience,
    required this.matchedKeywords,
  });

  factory MatchResult.fromJson(Map<String, dynamic> json) {
    return MatchResult(
      matchScore: json['match_score'] ?? 0,
      summary: json['summary'] ?? '',
      matchedSkills: List<String>.from(json['matched_skills'] ?? []),
      matchedExperience: List<String>.from(json['matched_experience'] ?? []),
      matchedKeywords: List<String>.from(json['matched_keywords'] ?? []),
    );
  }
}
