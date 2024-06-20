// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_challenge/models/option_model.dart';

class OptionsProvider extends ChangeNotifier {
  addOption(OptionModel option) {
    _optionList.add(option);
    notifyListeners();
  }

  removeOption(OptionModel option) {
    _optionList
        .removeWhere((element) => element.identifier == option.identifier);
    notifyListeners();
  }

  List<OptionModel> get optionList => _optionList;
  List<OptionModel> _optionList = [
    OptionModel.fromJson(
      {
        "strike_price": 100,
        "type": "Call",
        "bid": 10.05,
        "ask": 12.04,
        "long_short": "long",
        "expiration_date": "2025-12-17T00:00:00Z"
      },
    ),
    OptionModel.fromJson(
      {
        "strike_price": 102.50,
        "type": "Call",
        "bid": 12.10,
        "ask": 14,
        "long_short": "long",
        "expiration_date": "2025-12-17T00:00:00Z"
      },
    ),
    OptionModel.fromJson(
      {
        "strike_price": 103,
        "type": "Put",
        "bid": 14,
        "ask": 15.50,
        "long_short": "short",
        "expiration_date": "2025-12-17T00:00:00Z"
      },
    ),
    OptionModel.fromJson({
      "strike_price": 105,
      "type": "Put",
      "bid": 16,
      "ask": 18,
      "long_short": "long",
      "expiration_date": "2025-12-17T00:00:00Z"
    }),
  ];
}
