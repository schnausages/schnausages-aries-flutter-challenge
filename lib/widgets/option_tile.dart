import 'package:flutter/material.dart';
import 'package:flutter_challenge/models/option_model.dart';
import 'package:flutter_challenge/styles.dart';

class OptionTile extends StatelessWidget {
  final OptionModel option;
  final VoidCallback onTilePress;
  final bool active;
  const OptionTile(
      {super.key,
      required this.option,
      required this.onTilePress,
      required this.active});

  @override
  Widget build(BuildContext context) {
    final bool isCall = option.optionType == OptionType.Call;
    final Color activeColor =
        isCall ? AppStyles.ariesGreenMain : AppStyles.ariesPurpleMain;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Material(
        color: Colors.transparent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadowColor: const Color(0xFFC1C6CA),
        child: ListTile(
            onTap: () => onTilePress(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            tileColor: active ? activeColor : AppStyles.baseTileColor,
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(Icons.circle,
                      color: !active ? activeColor : Colors.white, size: 8),
                ),
                Text(
                  isCall ? "Call" : "Put",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: active ? Colors.white : AppStyles.baseTextColor,
                      fontSize: 20),
                ),
              ],
            ),
            trailing: Text(
              "\$${option.strikePrice.toStringAsFixed(2)}",
              style: AppStyles.mainHeaderStyle.copyWith(
                  fontSize: 22,
                  color: active ? Colors.white : AppStyles.baseTextColor),
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  option.positionType == PositionType.long ? 'long' : "short",
                  style: TextStyle(
                      color: active ? Colors.white : Colors.blueGrey[300],
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                const _SpaceDiv(),
                Text(
                  "Ask ${option.ask.toString()}",
                  style: TextStyle(
                    color: active ? Colors.white : Colors.blueGrey[300],
                    fontSize: 12,
                  ),
                ),
                const _SpaceDiv(),
                Text(
                  "Bid ${option.bid.toString()}",
                  style: TextStyle(
                    color: active ? Colors.white : Colors.blueGrey[300],
                    fontSize: 12,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class _SpaceDiv extends StatelessWidget {
  const _SpaceDiv();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
    );
  }
}
