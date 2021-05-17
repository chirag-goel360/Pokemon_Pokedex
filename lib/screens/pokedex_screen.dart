import 'package:flutter/material.dart';
import 'package:pokedex/services/pokemonapi.dart';
import 'package:pokedex/widgets/pokedexgrid.dart';
import 'package:pokedex/widgets/pokedexlist.dart';

class PokeDexScreen extends StatefulWidget {
  @override
  _PokeDexScreenState createState() => _PokeDexScreenState();
}

class _PokeDexScreenState extends State<PokeDexScreen> {
  bool displayGrid = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPokemons(),
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
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal.shade200,
              elevation: 0,
              title: Text(
                'Pokedex',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    displayGrid ? Icons.view_list : Icons.view_module,
                    color: Colors.black38,
                  ),
                  onPressed: () {
                    setState(() {
                      displayGrid = !displayGrid;
                    });
                  },
                ),
              ],
            ),
            body: displayGrid
                ? GridView.builder(
                    padding: EdgeInsets.all(15),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 500 ? 4 : 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.25,
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return PokeDexGrid(
                        pokemon: snapshot.data[index]['url'],
                      );
                    },
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 3,
                        ),
                        child: PokeDexList(
                          pokemon: snapshot.data[index]['url'],
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
