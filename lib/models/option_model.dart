// ignore: constant_identifier_names
import 'dart:math';

enum OptionType { Call, Put }

enum PositionType { long, short }

/// [OptionModel] holds data for each option contract, providing a pseudo ID for the
/// time being for the sake of adding / removing with state mgmt functions
class OptionModel {
  final double strikePrice;
  final OptionType optionType;
  final double bid;
  final double ask;
  final PositionType positionType;
  final DateTime expireDate;
  final String identifier;

  OptionModel(
      {required this.strikePrice,
      required this.optionType,
      required this.bid,
      required this.ask,
      required this.identifier,
      required this.positionType,
      required this.expireDate});

  double maxProfitForOption() {
    double maxProfit = 0.0;

    if (optionType == OptionType.Call) {
      maxProfit = double.infinity; // theoretically / literally unlimited
    } else if (optionType == OptionType.Put) {
      maxProfit =
          ask; // Highest profit potential only what is received from ask price
    }

    return maxProfit;
  }

  double maxLossForOption() {
    double maxLoss = 0.0;

    if (optionType == OptionType.Call) {
      maxLoss = -ask; // Option's loss equates to contract's ask amount
    } else if (optionType == OptionType.Put) {
      maxLoss = strikePrice - ask;
    }

    return maxLoss;
  }

  double breakeven() {
    double breakEvenPoint = 0.0;

    if (optionType == OptionType.Call) {
      breakEvenPoint = strikePrice + ask;
    } else if (optionType == OptionType.Put) {
      breakEvenPoint = strikePrice - ask;
    }

    return breakEvenPoint;
  }

  /// provides x axis values for option contract as this is not known ahead of chart construction
  /// see [https://www.investopedia.com/trading/options-risk-graphs/#toc-options-and-volatility-risk]
  List<double> underlyingPrices(double strikePrice) {
    // Finding numbers below 'value' at increments of 2.5 --assuming this is standard incrementing

    double minX = strikePrice - 7.5;
    double min2 = strikePrice - 5;
    double min3 = strikePrice - 2.5;
    double max1 = strikePrice + 2.5;
    double max2 = strikePrice + 5;
    double maxX = strikePrice + 7.5;

    List<double> underlyingPrices = [
      minX,
      min2,
      min3,
      strikePrice,
      max1,
      max2,
      maxX
    ];
    underlyingPrices.sort((a, b) => a.compareTo(b));
    return underlyingPrices;
  }

  /// [getMaxY] will adjust max chart y axis as max profit is unknown
  /// ahead of chart construction and will vary per option
  double getMaxY(List<double> prices) {
    var profitLoss = List.generate(
        prices.length, (index) => profitLossForOption(prices[index]));
    double maxY = profitLoss[0]; // Initialize max with the first element
    for (int i = 1; i < profitLoss.length; i++) {
      if (profitLoss[i] > maxY) {
        maxY = profitLoss[i];
      }
    }
    return maxY + 5;
  }

  /// [getMinY] will adjust min chart y axis as min profit is unknown
  /// ahead of chart construction and will vary per option
  double getMinY(List<double> prices) {
    double minProfit = 0.0;

    for (var p in prices) {
      double pL = profitLossForOption(p);
      if (pL < minProfit) {
        minProfit = pL;
      }
    }
    return minProfit - 2;
  }

  double profitLossForOption(double underlyingPrice) {
    double profitLoss = 0.0;

// Call profit made when stock underlying price surpasses contract,
// to then sub strike and ask price for margin
    if (optionType == OptionType.Call) {
      if (underlyingPrice >= strikePrice) {
        profitLoss = underlyingPrice - strikePrice - ask;
      } else {
        profitLoss = -ask;
      }
    } else if (optionType == OptionType.Put) {
      if (underlyingPrice <= strikePrice) {
        profitLoss = strikePrice - underlyingPrice - ask;
      } else {
        profitLoss = -ask;
      }
    }

    return profitLoss;
  }

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    double strike = json['strike_price'].toDouble();
    String id = Random().nextInt(99999).toString();
// Convert to enum
    OptionType option = OptionType.values
        .firstWhere((e) => e.toString() == "OptionType.${json['type']}");
    double bid = json['bid'].toDouble();
    double ask = json['ask'].toDouble();
    PositionType position = PositionType.values.firstWhere(
        (e) => e.toString() == "PositionType.${json['long_short']}");

    DateTime expire = DateTime.parse(json['expiration_date']);
    return OptionModel(
        strikePrice: strike,
        optionType: option,
        ask: ask,
        bid: bid,
        identifier: id,
        positionType: position,
        expireDate: expire);
  }
  Map<String, dynamic> toJson() => {
        'strike_price': strikePrice,
        'type': optionType.toString(),
        'bid': bid,
        'id': identifier,
        'ask': ask,
        'long_short': positionType.toString(),
        'expiration_date': expireDate.toIso8601String()
      };
}
