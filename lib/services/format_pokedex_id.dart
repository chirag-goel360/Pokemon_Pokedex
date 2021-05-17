String formatPokedexId(id) {
  String pokedexId = '000' + id;
  String result = pokedexId.substring(pokedexId.length - 3);
  return result;
}
