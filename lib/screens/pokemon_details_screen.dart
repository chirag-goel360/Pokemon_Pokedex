import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/services/capitalize_string.dart';
import 'package:pokedex/services/color.dart';
import 'package:pokedex/widgets/tiledata.dart';
import 'package:pokedex/widgets/listdivider.dart';
import 'package:pokedex/widgets/pokemontypes.dart';

class PokemonDetailsScreen extends StatefulWidget {
  final String image;
  final String id;
  final String name;
  final String primaryType;
  final String weight;
  final List<String> types;
  final List<String> attacks;
  final List<String> attackPower;

  const PokemonDetailsScreen({
    Key key,
    @required this.image,
    @required this.id,
    @required this.name,
    @required this.primaryType,
    @required this.types,
    this.weight,
    this.attacks,
    this.attackPower,
  }) : super(key: key);

  @override
  _PokemonDetailsScreenState createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  List<Color> _colors = [
    Colors.indigo.shade200,
    Colors.purple.shade200,
  ];
  List<double> _stops = [
    0.9,
    0.1,
  ];
  bool vis = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getTypeColor(widget.primaryType),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              capitalize(widget.name),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 2,
                    color: Colors.blueGrey,
                  ),
                ],
              ),
            ),
            Text(
              '# ' + widget.id,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 2,
                    color: Colors.blueGrey,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: PokemonTypes(
                types: widget.types,
                displayRow: true,
              ),
            ),
            Text(
              '⚡ ' + widget.weight + ' KG',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 2,
                    color: Colors.blueGrey,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  vis = !vis;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _colors,
                    stops: _stops,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          capitalize(widget.name),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      height: 50,
                      child: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: Colors.white70,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: vis,
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                decoration: BoxDecoration(
                  color: Color(0xfff3faff),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.attacks.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        TileData(
                          status: true,
                          name: widget.attacks[index],
                          amount: widget.attackPower[index],
                        ),
                        ListDivider(),
                      ],
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Hero(
                tag: '${widget.name} image',
                child: SvgPicture.network(
                  widget.image,
                  width: MediaQuery.of(context).size.width * 0.75,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
