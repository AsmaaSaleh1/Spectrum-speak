import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/rest_api_analysis.dart';

class PieChartSample1 extends StatefulWidget {
  const PieChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample1State();
}

class PieChartSample1State extends State {
  int touchedIndex = -1;
  var degree;
  var counts;

  Future<List<PieChartSectionData>> getChildrenCount() async {
    try {
      var data = await getChildrenCountByDegreeOfAutism();
      print(data);
      if (data != null) {
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

        return List.generate(
          3,
          (i) {
            final isTouched = i == touchedIndex;

            switch (i) {
              case 0:
                return PieChartSectionData(
                  color: kBlue,
                  value: counts[0],
                  title: "Level 1",
                  titleStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  radius: 110,
                  titlePositionPercentageOffset: 0.55,
                  borderSide: isTouched
                      ? BorderSide(color: Colors.white, width: 6)
                      : BorderSide(color: Colors.white.withOpacity(0)),
                );
              case 1:
                return PieChartSectionData(
                  color: kYellow,
                  value: counts[1],
                  title: "Level 2",
                  titleStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  radius: 95,
                  titlePositionPercentageOffset: 0.55,
                  borderSide: isTouched
                      ? const BorderSide(color: Colors.white, width: 6)
                      : BorderSide(
                          color: Colors.white.withOpacity(0),
                        ),
                );
              case 2:
                return PieChartSectionData(
                  color: kRed,
                  value: counts[2],
                  title: "Level 3",
                  titleStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  radius: 80,
                  titlePositionPercentageOffset: 0.6,
                  borderSide: isTouched
                      ? const BorderSide(
                          color: Colors.white,
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
        );
      }
    } catch (e) {
      print("error in getChildrenCount : $e");
      return List.generate(3, (i) => PieChartSectionData(value: 0.0));
    }
    return List.generate(3, (i) => PieChartSectionData(value: 0.0));
  }

  @override
  void initState() {
    super.initState();
    getChildrenCount();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:20,left: 10),
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
                child: FutureBuilder<List<PieChartSectionData>>(
                  future: getChildrenCount(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Handle loading state if needed
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // Handle error state if needed
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else {
                      // If the data is ready, use it to build the PieChart
                      return PieChart(
                        PieChartData(
                          startDegreeOffset: 180,
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 1,
                          centerSpaceRadius: 0,
                          sections: snapshot.data ?? [],
                        ),
                      );
                    }
                  },
                ),
              ),
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
          width: 16,
          height:16,
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
