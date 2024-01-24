import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/rest_api_analysis.dart';

class PieChartDegreeOfAutism extends StatefulWidget {
  const PieChartDegreeOfAutism({super.key});

  @override
  State<StatefulWidget> createState() => PieChartDegreeOfAutismState();
}

class PieChartDegreeOfAutismState extends State {
  int touchedIndex = -1;
  var degree;
  var counts;

  Future<void> getChildrenCount() async {
    var data = await getChildrenCountByDegreeOfAutism();
    if (data != null) {
      setState(() {
        degree = data.keys.toList();
        counts = data.values.map((value) {
          if (value is int) {
            return value.toDouble();
          } else if (value is double) {
            return value;
          } else {
            return 0.0;
          }
        }).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getChildrenCount();
  }

  @override
  Widget build(BuildContext context) {
    if (degree == null || counts == null) {
      return Container();
    }
    return Container(
      height: 400,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    FontAwesomeIcons.solidCircle,
                    size: 22.0,
                    color: kDarkBlue,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Degree of Autism",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: kDarkerColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildLegendItem(kBlue, "ASD Level 1", 0),
                buildLegendItem(kYellow, "ASD Level 2", 1),
                buildLegendItem(kRed, "ASD Level 3", 2),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            setState(() {
                              touchedIndex =
                                  -1; // Reset touchedIndex when not touched
                            });
                            return;
                          }

                          setState(() {
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      startDegreeOffset: 180,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 1,
                      centerSpaceRadius: 0,
                      sections: List.generate(
                        3,
                        (i) {
                          final isTouched = i == touchedIndex;

                          switch (i) {
                            case 0:
                              return PieChartSectionData(
                                color: kBlue,
                                value: counts[0],
                                title: isTouched
                                    ? counts[0].toString()
                                    : "Level 1",
                                titleStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                radius: 110,
                                titlePositionPercentageOffset: 0.55,
                                borderSide: isTouched
                                    ? BorderSide(
                                        color: kPrimary,
                                        width: 6,
                                      )
                                    : BorderSide(
                                        color: Colors.white.withOpacity(0),
                                      ),
                              );
                            case 1:
                              return PieChartSectionData(
                                color: kYellow,
                                value: counts[1],
                                title: isTouched
                                    ? counts[1].toString()
                                    : "Level 2",
                                titleStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                radius: 95,
                                titlePositionPercentageOffset: 0.55,
                                borderSide: isTouched
                                    ? const BorderSide(
                                        color: kPrimary,
                                        width: 6,
                                      )
                                    : BorderSide(
                                        color: Colors.white.withOpacity(0),
                                      ),
                              );
                            case 2:
                              return PieChartSectionData(
                                color: kRed,
                                value: counts[2],
                                title: isTouched
                                    ? counts[2].toString()
                                    : "Level 3",
                                titleStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                radius: 80,
                                titlePositionPercentageOffset: 0.6,
                                borderSide: isTouched
                                    ? const BorderSide(
                                        color: kPrimary,
                                        width: 6,
                                      )
                                    : BorderSide(
                                        color: Colors.white.withOpacity(0),
                                      ),
                              );
                            default:
                              throw Error();
                          }
                        },
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLegendItem(Color color, String text, int index) {
    return Row(
      children: [
        Container(
          width: touchedIndex == index ? 20 : 16,
          height: touchedIndex == index ? 20 : 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: kDarkerColor,
          ),
        ),
      ],
    );
  }

}
