import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/rest_api_analysis.dart';
import 'package:spectrum_speak/units/build_drop_down_menu.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartDataByCity extends StatefulWidget {
  const BarChartDataByCity({Key? key}) : super(key: key);

  @override
  State<BarChartDataByCity> createState() => _BarChartDataByCityState();
}

class _BarChartDataByCityState extends State<BarChartDataByCity> {
  Map<String, dynamic> usersData = {};
  String? selectedCity;
  List<BarChartGroupData> barGroups = [];
  var xAxis = ["Parent", "Specialist  ", " Shadow Teacher", "Center"];
  int touchedGroupIndex = -1;
  double y = 0;
  Future<void> getUsersCount(String city) async {
    try {
      var data = await getUsersCountByCity(city);
      var color = [kRed, kYellow.withGreen(180), kBlue, kGreen];
      setState(() {
        // Assuming data is a map with string keys and dynamic values
        if (data != null) {
          var categories = data.keys.toList();
          var counts = data.values.map((value) {
            if (value is int) {
              return value.toDouble();
            } else if (value is double) {
              return value;
            } else {
              return 0.0; // or handle other types as needed
            }
          }).toList();
          double maxCount =
              counts.isNotEmpty ? counts.reduce((a, b) => a > b ? a : b) : 0.0;
          y = maxCount + (maxCount % 2 == 0 ? 4 : 3);
          barGroups = List.generate(categories.length, (index) {
            double value = counts[index];
            Color colorColumn = color[index];
            return BarChartGroupData(
              barsSpace: 4,
              x: index,
              barRods: [
                BarChartRodData(
                    toY: value,
                    color: colorColumn,
                    width: 40,
                    borderRadius: BorderRadius.circular(3)),
              ],
              showingTooltipIndicators: touchedGroupIndex == index ? [0] : [],
            );
          });
        }
      });
    } catch (error) {
      print('Error fetching users data: $error');
    }
  }

  void onCityChanged(String? value) {
    setState(() {
      selectedCity = value;
    });
    getUsersCount(selectedCity!);
  }

  @override
  void initState() {
    super.initState();
    getUsersCount("All");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        "Data By City",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: kDarkerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 40),
                  child: CustomDropDown(
                    items: const [
                      'All',
                      'Nablus',
                      'Ramallah',
                      'Jerusalem',
                      'Bethlehem',
                      'Qalqilya',
                      'Hebron',
                      'Jenin',
                      'Tulkarm',
                    ],
                    selectedValue: selectedCity,
                    hint: 'Select City',
                    onChanged: onCityChanged,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 30, left: 5),
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
                      tooltipMargin: 2,
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
                    ),
                    touchCallback: (event, response) {
                      if (event.isInterestedForInteractions &&
                          response != null &&
                          response.spot != null) {
                        setState(() {
                          touchedGroupIndex =
                              response.spot!.touchedBarGroupIndex;
                        });
                      } else {
                        setState(() {
                          touchedGroupIndex = -1;
                        });
                      }
                    },
                  ),
                  barGroups: barGroups,
                  minY: 0,
                  maxY: y,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: kDarkerColor.withOpacity(0.5),
                      strokeWidth: 1,
                    ),
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
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
