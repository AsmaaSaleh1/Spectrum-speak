import 'package:flutter/material.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';
class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopBar(
        body: AnalysisCall(),
      ),
    );
  }
}
class AnalysisCall extends StatefulWidget {
  const AnalysisCall({super.key});

  @override
  State<AnalysisCall> createState() => _AnalysisCallState();
}

class _AnalysisCallState extends State<AnalysisCall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
