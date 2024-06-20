// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    // final apiService = OptionsNetworkService()
    // config our state mgmt getter here for list of options
    // final options = json.decode('option_list.json');
    // or alternatively return a network request of real options data (from a test account?)
    // final options = apiService.fetchOptionsForUser()
    // build our current list of options
    // final optionList =
    //     options.map<OptionModel>((element) => OptionModel(element)).toList();
    // init our state mgmt with option objs
    // optionService = OptionsProvider(options: optionList);
  });

  test('Buy an option -> append to optionService mgmt', () {
    // final mockNewOption = OptionModel.fromJson(json.decode('mock_new_option.json'));
    // final res = apiService.purchaseContract(userAuthCredentials, mockNewOption);
    // final OptionModel option = OptionModel.fromJson(res.body['option']);
    // optionService.addOption(option);
    // expect(optionService.options.last.identifier, mockNewOption.identifier);
  });
}
