import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/screens/pokemon_details_screen.dart';
import 'package:pokedex/services/capitalize_string.dart';
import 'package:pokedex/services/format_pokedex_id.dart';
import 'package:pokedex/services/pokemonapi.dart';
import 'package:pokedex/services/color.dart';
import 'package:pokedex/widgets/pokemontypes.dart';

class PokeDexList extends StatefulWidget {
  final String pokemon;
  const PokeDexList({
    Key key,
    this.pokemon,
  }) : super(key: key);

  @override
  _PokeDexListState createState() => _PokeDexListState();
}

class _PokeDexListState extends State<PokeDexList> {
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
        if (!snapshot.hasData) {
          return Material(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.teal,
              ),
            ),
          );
        }
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
                height: 70,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: getTypeColor(primaryType),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    PokemonTypes(
                      types: types,
                      displayRow: true,
                    ),
                  ],
                ),
              ),
              Container(
                width: 70,
                height: 70,
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
