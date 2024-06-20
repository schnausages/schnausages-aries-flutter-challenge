// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_challenge/models/option_model.dart';
import 'package:flutter_challenge/options_provider.dart';
import 'package:flutter_challenge/screens/graph_home.dart';
import 'package:flutter_challenge/styles.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: OptionsProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'Options Profit Calculator',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppStyles.ariesPurpleMain),
            useMaterial3: true,
          ),
          // presumably app would call api to init our state mgmt to then supply our
          // options through the app -- providing hardcoded list of objs from provider for now
          // since there is no api
          home: Consumer<OptionsProvider>(
            builder: (context, service, _) =>
                OptionsCalculator(optionsData: service.optionList),
          )),
    );
  }
}

class OptionsCalculator extends StatefulWidget {
  const OptionsCalculator({super.key, required this.optionsData});
  final List<OptionModel> optionsData;

  // final List<Map<String, dynamic>> optionsData;

  @override
  State<OptionsCalculator> createState() => _OptionsCalculatorState();
}

class _OptionsCalculatorState extends State<OptionsCalculator> {
  List<OptionModel> optionsData = [];
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    optionsData = widget.optionsData;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Options Profit Calculator",
          style: TextStyle(
              color: AppStyles.baseTextColor, fontWeight: FontWeight.w600),
        ),
      ),
      body: OptionsHome(options: optionsData),
    );
  }
}
