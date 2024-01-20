import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/widgets/bar_chart_children_by_old_gender.dart';
import 'package:spectrum_speak/widgets/bar_chart_data_by_city_for_analysis.dart';
import 'package:spectrum_speak/widgets/pie_chart_degree_of_autism.dart';
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
              BarChartDataByCity(),
              Divider(
                color: kDarkerColor,
                thickness: 2.0,
                indent: 20,
                endIndent: 20,
              ),
              PieChartDegreeOfAutism(),
              Divider(
                color: kDarkerColor,
                thickness: 2.0,
                indent: 20,
                endIndent: 20,
              ),
              BarChartChildrenGroupedByOldAndGender(),
            ],
          ),
        ),
      ),
    );
  }
}
