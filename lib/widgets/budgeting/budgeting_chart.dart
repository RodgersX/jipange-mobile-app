import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// ignore: use_key_in_widget_constructors
class BudgetFlChart extends StatelessWidget {
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
        handleBuiltInTouches: true,
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
                  color: Color(0xff72719b),
                  fontWeight: FontWeight.bold,
                  fontSize: 8,
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
            }),
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
        blurRadius: 11,
        offset: Offset(2.0, 7.0),
        color: Color.fromRGBO(112, 0, 255, 0.37),
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
        const Color.fromRGBO(220, 195, 253, 0.5),
      ],
      barWidth: 6,
      isStrokeCapRound: false,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    final lineChartBarData2 = LineChartBarData(
      shadow: const Shadow(
        blurRadius: 11,
        offset: Offset(2.0, 7.0),
        color: Color.fromRGBO(39, 208, 168, 1),
      ),
      spots: [
        FlSpot(1, 1.2),
        FlSpot(2, 1.7),
        FlSpot(3, 1.6),
        FlSpot(4, 3.6),
        FlSpot(5, 2.3),
        FlSpot(6, 2.5),
      ],
      isCurved: true,
      colors: [
        const Color.fromRGBO(39, 208, 168, 1),
      ],
      barWidth: 6,
      isStrokeCapRound: false,
      dotData: FlDotData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
    ];
  }
}
