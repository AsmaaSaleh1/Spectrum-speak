import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/widgets/data_by_city_for_analysis.dart';
import 'package:spectrum_speak/widgets/pie_chart_gender.dart';
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.chartPie,
                        size: 50.0,
                        color: kDarkBlue,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Analysis",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: kDarkerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              DataByCity(),
              Divider(
                color: kDarkerColor, // You can customize the color
                thickness: 2.0, // You can customize the thickness
                indent: 20,
                endIndent: 20,
              ),
              PieChartSample1(),
            ],
          ),
        ),
      ),
    );
  }
}
