import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/screens/pokemon_details_screen.dart';
import 'package:pokedex/services/capitalize_string.dart';
import 'package:pokedex/services/format_pokedex_id.dart';
import 'package:pokedex/services/pokemonapi.dart';
import 'package:pokedex/services/color.dart';
import 'package:pokedex/widgets/pokemontypes.dart';

class PokeDexGrid extends StatefulWidget {
  final String pokemon;
  const PokeDexGrid({
    Key key,
    this.pokemon,
  }) : super(key: key);

  @override
  _PokeDexGridState createState() => _PokeDexGridState();
}

class _PokeDexGridState extends State<PokeDexGrid> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPokemon(widget.pokemon),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error',
            ),
          );
        }
        if (!snapshot.hasData)
          return Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        Map pokemon = snapshot.data;
        String image =
            pokemon['sprites']['other']['dream_world']['front_default'];
        String name = pokemon['species']['name'];
        List<String> types = [];
        pokemon['types'].forEach((type) => types.add(type['type']['name']));
        String primaryType = types[0];
        String id = pokemon['id'].toString();
        List<String> attacks = [];
        List<String> attackPower = [];
        pokemon['stats'].forEach((stat) => attacks.add(stat['stat']['name']));
        pokemon['stats']
            .forEach((value) => attackPower.add(value['base_stat'].toString()));
        String weight = pokemon['weight'].toString();
        String pokedexId = formatPokedexId(id);
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PokemonDetailsScreen(
                id: pokedexId,
                image: image,
                name: name,
                primaryType: primaryType,
                weight: weight,
                types: types,
                attackPower: attackPower,
                attacks: attacks,
              ),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: getTypeColor(primaryType),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      capitalize(name),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 2,
                            color: Colors.blueGrey,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    PokemonTypes(
                      types: types,
                      displayRow: false,
                    ),
                  ],
                ),
              ),
              Container(
                width: 90,
                height: 90,
                padding: EdgeInsets.all(5),
                child: Hero(
                  tag: '$name image',
                  child: SvgPicture.network(
                    image,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
