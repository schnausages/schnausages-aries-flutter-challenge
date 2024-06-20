import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_challenge/models/option_model.dart';
import 'package:flutter_challenge/widgets/option_tile.dart';
import 'package:flutter_challenge/widgets/options_risk_reward_graph.dart';

/// Presents metrics for selection option from list view with
/// PL chart + metric boxes always visible
class OptionsHome extends StatefulWidget {
  final List<OptionModel> options;
  const OptionsHome({super.key, required this.options});

  @override
  State<OptionsHome> createState() => _OptionsHomeState();
}

class _OptionsHomeState extends State<OptionsHome> {
  int activeOption = 0;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      slivers: [
        SliverToBoxAdapter(
          child: OptionsRiskRewardGraph(
            option: widget.options[activeOption],
            underlyingPrices: widget.options[activeOption]
                .underlyingPrices(widget.options[activeOption].strikePrice),
          ),
        ),
        SliverFillRemaining(
          child: ListView.builder(
              itemCount: widget.options.length,
              itemBuilder: (context, i) => OptionTile(
                    option: widget.options[i],
                    active: activeOption == i,
                    onTilePress: () {
                      setState(() {
                        activeOption = i;
                      });
                    },
                  )),
        )
      ],
    );
  }
}
