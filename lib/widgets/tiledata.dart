import 'package:flutter/material.dart';
import '../services/capitalize_string.dart';

class TileData extends StatelessWidget {
  final String name;
  final bool status;
  final String amount;
  const TileData({
    this.name,
    this.status,
    this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          status ? Icons.check_circle_outline : Icons.highlight_off,
          color: status ? Colors.green.shade400 : Colors.red.shade300,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          capitalize(name),
          style: TextStyle(
            color: Colors.pink,
            fontSize: 16,
          ),
        ),
        Spacer(),
        Row(
          children: [
            Text(
              amount,
              style: TextStyle(
                color: Colors.purple,
                fontSize: 18,
              ),
            ),
            Text(
              " HP",
              style: TextStyle(
                color: Colors.orangeAccent,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
