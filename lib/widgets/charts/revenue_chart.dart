import 'dart:developer';

import 'package:ecommerce_admin_tut/provider/statictic_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _LineChart extends StatelessWidget {
  StatictisProvider statictisProvider;

  _LineChart({required this.statictisProvider});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: _lineTouchData(),
        gridData: FlGridData(show: false),
        titlesData: _titlesData(),
        borderData: _flBorderData(),
        lineBarsData: [
          LineChartBarData(
              isCurved: true,
              color: const Color(0xff27b6fc),
              barWidth: 8,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              spots: [
                FlSpot(1, statictisProvider.revenues[0]),
                // FlSpot(8, statictisProvider.revenues[1]),
                FlSpot(15, statictisProvider.revenues[2]),
              ],),
        ],
        minX: 0,
        maxX: 16,
        maxY: 4,
        minY: 0,
      ),
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineTouchData _lineTouchData() {
    return LineTouchData(
      handleBuiltInTouches: true,
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
      ),
    );
  }

  FlBorderData _flBorderData() {
    return FlBorderData(
      show: true,
      border: const Border(
        bottom: BorderSide(color: Color(0xff4e4965), width: 4),
        left: BorderSide(color: Colors.transparent),
        right: BorderSide(color: Colors.transparent),
        top: BorderSide(color: Colors.transparent),
      ),
    );
  }

  FlTitlesData _titlesData() {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: _bottomTitles(),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      leftTitles: AxisTitles(
        sideTitles: leftTitles(),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = statictisProvider.dataX[0];
        break;
      case 2:
        text = statictisProvider.dataX[1];
        break;
      case 3:
        text = statictisProvider.dataX[2];
        break;
      case 4:
        text = statictisProvider.dataX[3];
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff72719b),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text = const Text('');
    int length = statictisProvider.statistics.length-1;
    double jump = 0;
    int index = length;
    for (double i = 1; i < 16; i = i + ((15 / length).floor() - 1)) {
      if (value.toInt() == 1) {
        text =
            Text('${statictisProvider.statistics[index].datee2}', style: style);
        index--;
      }
      if (value.toInt() != 0 && value.toInt() == jump.floor() && index > -1) {
        text =
            Text('${statictisProvider.statistics[index].datee2}', style: style);
        index--;
      }
      jump = jump + (15 / length);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles _bottomTitles() {
    return SideTitles(
      showTitles: true,
      reservedSize: 32,
      interval: 1,
      getTitlesWidget: bottomTitleWidgets,
    );
  }
}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  @override
  Widget build(BuildContext context) {
    final StatictisProvider statictisProvider =
        Provider.of<StatictisProvider>(context);
    return statictisProvider.isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : AspectRatio(
            aspectRatio: 1.23,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                gradient: LinearGradient(
                  colors: [
                    Color(0xff2c274c),
                    Color(0xff46426c),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: statictisProvider.statistics.isEmpty == true ? Container() : Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 37,
                      ),
                      const Text(
                        'Unfold Shop 2018',
                        style: TextStyle(
                          color: Color(0xff827daa),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        'Monthly Sales',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 37,
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 16.0, left: 6.0),
                          child: _LineChart(
                            statictisProvider: statictisProvider,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
