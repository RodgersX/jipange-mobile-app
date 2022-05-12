import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// ignore: use_key_in_widget_constructors
class CategoryFlChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampledata1(),
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData sampledata1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: false,
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingVerticalLine: (val) {
          return FlLine(
            color: const Color.fromRGBO(132, 132, 132, .16),
            strokeWidth: 4,
            dashArray: [3, 3],
          );
        },
        drawHorizontalLine: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 25,
          getTextStyles: (val) => const TextStyle(
            color:  Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          margin: 10,
          getTitles: (val) {
            switch (val.toInt()) {
              case 1:
                return 'Mar';
              case 2:
                return 'Apr';
              case 3:
                return 'May';
              case 4:
                return 'Jun';
              case 5:
                return 'Jul';
              case 6:
                return 'Aug';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 7,
      maxY: 7,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final lineChartBarData1 = LineChartBarData(
      shadow: const Shadow(
        blurRadius: 4,
        offset: Offset(1, 13),
        color: Color.fromRGBO(21, 21, 21, .25),
      ),
      spots: [
        FlSpot(1, 1),
        FlSpot(2, 2.5),
        FlSpot(3, 6.2),
        FlSpot(4, 3.0),
        FlSpot(5, 3.4),
        FlSpot(6, 5.4),
      ],
      isCurved: true,
      colors: [
        const Color.fromRGBO(0, 0, 0, 0),
        const Color.fromRGBO(252, 252, 252, 1),
        Colors.white,
        const Color.fromRGBO(255, 255, 255, 1),
      ],
      barWidth: 6,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    return [
      lineChartBarData1,
    ];
  }
}
