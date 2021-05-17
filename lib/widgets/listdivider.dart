import 'package:flutter/material.dart';

class ListDivider extends StatelessWidget {
  const ListDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      color: Colors.blueGrey.shade100,
    );
  }
}
