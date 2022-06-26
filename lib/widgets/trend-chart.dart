import 'package:cryptotrackerapp/utils/utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget buildChart(BuildContext context, List<FlSpot> priceData, int index) {
  return SizedBox(
    height: getDeviceHeight(context) / 5.4,
    width: getDeviceWidth(context) / 2.9,
    child: LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          show: false,
        ),
        gridData: FlGridData(
          show: false,
        ),
        borderData: FlBorderData(
          show: false,
        ),
        lineBarsData: [
          LineChartBarData(
            spots: priceData,
            //     [
            //   const FlSpot(0, 3),
            //   const FlSpot(2.6, 2),
            //   const FlSpot(4.9, 5),
            //   const FlSpot(6.8, 2.5),
            //   const FlSpot(8, 4),
            //   const FlSpot(9.5, 3),
            // ],
            isCurved: true,
            color: Colors.red,
            barWidth: 5,
            // dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.green,
            ),
          ),
        ],
      ),
    ),
  );
}
