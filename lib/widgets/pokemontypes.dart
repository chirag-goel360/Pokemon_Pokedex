import 'package:flutter/material.dart';
import 'package:pokedex/widgets/bubble.dart';

class PokemonTypes extends StatelessWidget {
  final List types;
  final bool displayRow;
  const PokemonTypes({
    Key key,
    @required this.types,
    @required this.displayRow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Bubble> typeBubbles = [];
    types.forEach((type) {
      typeBubbles.add(
        Bubble(
          type: type,
        ),
      );
    });
    return displayRow
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: typeBubbles,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: typeBubbles,
          );
  }
}
