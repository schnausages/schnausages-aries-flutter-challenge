// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_challenge/models/option_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_challenge/styles.dart';

// REF?
// https://www.investopedia.com/trading/options-risk-graphs/#toc-options-and-volatility-risk
class OptionsRiskRewardGraph extends StatelessWidget {
  final OptionModel option;
  final List<double> underlyingPrices;

  const OptionsRiskRewardGraph(
      {super.key, required this.option, required this.underlyingPrices});

  @override
  Widget build(BuildContext context) {
    final Size s = MediaQuery.of(context).size;
    final bool isCall = option.optionType == OptionType.Call;
    final Color activeColor =
        isCall ? AppStyles.ariesGreenMain : AppStyles.ariesPurpleMain;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _OptionsMetricBox(
                boxTitle: 'Breakeven',
                boxMetric: option.breakeven().toStringAsFixed(2),
                leadingWidget: Icon(
                  Icons.trending_neutral_rounded,
                  color: Colors.blueGrey,
                  size: 16,
                )),
            _OptionsMetricBox(
                boxTitle: 'Max Profit',
                boxMetric: option.maxProfitForOption().toStringAsFixed(2),
                leadingWidget: Icon(
                  Icons.trending_up_rounded,
                  color: AppStyles.ariesGreenMain,
                  size: 16,
                )),
            _OptionsMetricBox(
                boxTitle: 'Max Loss',
                boxMetric: option.maxLossForOption().toStringAsFixed(2),
                leadingWidget: Icon(
                  Icons.trending_down_rounded,
                  color: AppStyles.ariesRed,
                  size: 16,
                ))
          ],
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
          child: SizedBox(
            width: s.width,
            height: s.height * .275,
            child: AspectRatio(
              aspectRatio: 2,
              child: Row(
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: Text('Loss | Profit (\$)',
                        style: AppStyles.subHeaderStyle),
                  ),

                  /// Produces margin for contract at said
                  /// price with calculateProfitLoss of option
                  Flexible(
                    child: LineChart(
                      LineChartData(
                        borderData: FlBorderData(
                            border: const Border(
                                bottom: BorderSide(), left: BorderSide())),
                        lineTouchData: LineTouchData(
                          enabled: true,
                          touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: activeColor,
                            tooltipRoundedRadius: 20.0,
                            showOnTopOfTheChartBoxArea: true,
                            fitInsideHorizontally: true,
                            tooltipMargin: 6,
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map(
                                (LineBarSpot touchedSpot) {
                                  return LineTooltipItem(
                                    "\$${option.profitLossForOption(underlyingPrices[touchedSpot.spotIndex]).toStringAsFixed(2)}",
                                    AppStyles.subHeaderStyle.copyWith(
                                        color: Colors.white, fontSize: 14),
                                  );
                                },
                              ).toList();
                            },
                          ),
                          getTouchedSpotIndicator:
                              (LineChartBarData barData, List<int> indicators) {
                            return indicators.map(
                              (int index) {
                                final line = FlLine(
                                    color: Colors.grey,
                                    strokeWidth: 1,
                                    dashArray: [2, 4]);

                                return TouchedSpotIndicatorData(
                                  line,
                                  FlDotData(show: false),
                                );
                              },
                            ).toList();
                          },
                        ),
                        minX: underlyingPrices.first,
                        maxX: underlyingPrices.last,
                        maxY: option.getMaxY(underlyingPrices),
                        minY: option.getMinY(underlyingPrices),
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          rightTitles: SideTitles(showTitles: false),
                          topTitles: SideTitles(showTitles: false),
                          bottomTitles: SideTitles(
                              showTitles: true,
                              interval: 2.5,
                              getTitles: (value) {
                                return value.toStringAsFixed(0);
                              },
                              margin: 4,
                              getTextStyles: (context, value) =>
                                  AppStyles.smallLabelStyle),
                          // Y-axis title and interval configuration
                          leftTitles: SideTitles(
                              showTitles: true,
                              interval: 5.0,
                              getTitles: (value) {
                                return value.toStringAsFixed(0);
                              },
                              margin: 10,
                              getTextStyles: (context, value) =>
                                  AppStyles.smallLabelStyle),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                              colors: [activeColor],
                              barWidth: 4,
                              isStrokeCapRound: true,
                              shadow: Shadow(
                                  blurRadius: 1, color: Color(0xFFBBDEFB)),
                              spots: underlyingPrices
                                  .map((e) =>
                                      FlSpot(e, option.profitLossForOption(e)))
                                  .toList()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Text('at Price (\$)', style: AppStyles.subHeaderStyle),
      ],
    );
  }
}

/// Represent option metrics for Max Profit, Loss
/// and Breakeven on said contract. Will render
/// Unltd. for [OptionType.Call] as max profit is infinite
class _OptionsMetricBox extends StatelessWidget {
  final String boxMetric;
  final String boxTitle;
  final Widget leadingWidget;
  const _OptionsMetricBox(
      {super.key,
      required this.boxMetric,
      required this.leadingWidget,
      required this.boxTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            boxTitle,
            style: AppStyles.subHeaderStyle
                .copyWith(fontSize: 13, color: Colors.blueGrey[300]),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leadingWidget,
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(boxMetric == 'Infinity' ? "Unltd." : boxMetric,
                      style: AppStyles.subHeaderStyle.copyWith(fontSize: 18)),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
