import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/rest_api_analysis.dart';

class BarChartChildrenGroupedByOldAndGender extends StatefulWidget {
  BarChartChildrenGroupedByOldAndGender({super.key});

  @override
  State<BarChartChildrenGroupedByOldAndGender> createState() =>
      _BarChartChildrenGroupedByOldAndGenderState();
}

class _BarChartChildrenGroupedByOldAndGenderState
    extends State<BarChartChildrenGroupedByOldAndGender> {
  final pilateColor = kYellow;

  final quickWorkoutColor = kGreen;

  final betweenSpace = 0.2;

  var xAxis = [
    "0-3 years",
    "4-7 years",
    "8-11 years",
    "  12-15 years",
    " 16+ years"
  ];

  int touchedGroupIndex = -1;
  int touchedRodIndex = -1;
  double y = 0;
  var categories;
  var counts;
  var data;
  late List<dynamic> male = [];
  late List<dynamic> female = [];

  Future<void> getChildrenCount() async {
    try {
      data = await getChildrenCountGroupedByOldAndGender();
      setState(() {
        if (data != null) {
          // Convert numbers in "Male" and "Female" lists to doubles
          male = data["Male"].map((value) => value.toDouble()).toList();
          female = data["Female"].map((value) => value.toDouble()).toList();
          categories = data.keys.toList();

          counts = data.values
              .map((value) => value.fold(0, (a, b) => a + b).toDouble())
              .toList();
          double maxCount =
              counts.isNotEmpty ? counts.reduce((a, b) => a > b ? a : b) : 0.0;
          y = maxCount + (maxCount % 2 == 0 ? 4 : 3);
        }
      });
    } catch (error) {
      print('Error fetching children data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getChildrenCount();
  }

  BarChartGroupData generateGroupData(
    int x,
    double Female,
    double Male,
  ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: Female,
          color: pilateColor,
          width: touchedGroupIndex == x && touchedRodIndex == 0 ? 17 : 12,
        ),
        BarChartRodData(
          fromY: Female + betweenSpace,
          toY: Female + betweenSpace + Male,
          color: quickWorkoutColor,
          width: touchedGroupIndex == x && touchedRodIndex == 1 ? 17 : 12,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.minHeight;
        double linePadding;
        if (screenWidth >= 1200) {
          linePadding = 110;
        } else if (screenWidth >= 800) {
          linePadding = 70;
        } else {
          linePadding = 20;
        }
        if (male == [] || female == [] || data == null) {
          return Container();
        }
        return Container(
          height: 600,
          child: Scaffold(
            body: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: linePadding,
                      top: 20,
                      bottom: 0,
                      right: linePadding),
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
                        "Children group by Age and Gender",
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
                    buildLegendItem(kYellow, categories[1], 1),
                    buildLegendItem(kGreen, categories[0], 0),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                const SizedBox(height: 30),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(right: 40, left: 5),
                    width: 400,
                    height: 300,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: Colors.transparent,
                            tooltipPadding: EdgeInsets.zero,
                            tooltipMargin: -25,
                            getTooltipItem: (
                              BarChartGroupData group,
                              int groupIndex,
                              BarChartRodData rod,
                              int rodIndex,
                            ) {
                              return BarTooltipItem(
                                rod.toY.toString(),
                                TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: rod.color,
                                  fontSize: 18,
                                ),
                              );
                            },
                            fitInsideHorizontally: true,
                            fitInsideVertically: true,
                            tooltipHorizontalOffset: 20,
                          ),
                          touchCallback: (event, response) {
                            if (event.isInterestedForInteractions &&
                                response != null &&
                                response.spot != null) {
                              setState(() {
                                touchedGroupIndex =
                                    response.spot!.touchedBarGroupIndex;
                                touchedRodIndex =
                                    response.spot!.touchedRodDataIndex;
                              });
                            } else {
                              setState(() {
                                touchedGroupIndex = -1;
                                touchedRodIndex = -1;
                              });
                            }
                          },
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border(
                            top: BorderSide.none, // Remove top border
                            right: BorderSide.none, // Remove right border
                            bottom: BorderSide(
                              color: kDarkerColor,
                              width: 2,
                            ),
                            left: BorderSide(
                              color: kDarkerColor,
                              width: 2,
                            ),
                          ),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                            showTitles: true,
                          )),
                          rightTitles: const AxisTitles(),
                          topTitles: const AxisTitles(),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 50,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                if (index >= 0 && index < xAxis.length) {
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    child: Text(
                                      xAxis[index],
                                      style: TextStyle(
                                        color: kDarkerColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  );
                                }
                                return SizedBox
                                    .shrink(); // Return an empty widget if index is out of bounds
                              },
                            ),
                          ),
                        ),
                        gridData: const FlGridData(show: false),
                        barGroups: [
                          generateGroupData(
                            0,
                            male[0],
                            female[0],
                          ),
                          generateGroupData(
                            1,
                            male[1],
                            female[1],
                          ),
                          generateGroupData(
                            2,
                            male[2],
                            female[2],
                          ),
                          generateGroupData(
                            3,
                            male[3],
                            female[3],
                          ),
                          generateGroupData(
                            4,
                            male[4],
                            female[4],
                          ),
                        ],
                        maxY: y,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Widget buildLegendItem(Color color, String text, int index) {
  return Row(
    children: [
      Container(
        width: 17,
        height: 17,
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
