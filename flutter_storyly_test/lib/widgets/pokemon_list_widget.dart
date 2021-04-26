import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_storyly_test/pokemon_detail_page.dart';
import 'package:flutter_storyly_test/app_values.dart';
import 'package:flutter_storyly_test/data.dart';

class PokemonListWidget extends StatefulWidget {
  @override
  _PokemonListWidgetState createState() => _PokemonListWidgetState();
}

class _PokemonListWidgetState extends State<PokemonListWidget> {
  List<Pokemon> _pokemonList = <Pokemon>[];

  @override
  void initState() {
    super.initState();
    loadPokemon();
  }

  void onPokemonTap(context, pokemon) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PokemonDetailPageState(pokemon: pokemon),
      ),
    );
  }

  void loadPokemon() {
    fetchPokemons()
        .then((pokemonList) => setState(() {
              _pokemonList = pokemonList;
            }))
        .catchError((error) =>
            onFailShowSnackBar(context, "fetch pokemon failed", loadPokemon));
  }

  Widget _buildListTileFront(BuildContext context, int index) {
    final pokemon = _pokemonList[index];
    return GestureDetector(
      onTap: () => onPokemonTap(context, pokemon), // handle your onTap here
      child: Container(
          margin: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            child: Container(
              color: Colors.white,
              child: Column(children: [
                CachedNetworkImage(
                    height: 150,
                    width: 150,
                    fit: BoxFit.fitHeight,
                    placeholder: (context, url) => Transform.scale(
                        scale: 0.5,
                        child: CircularProgressIndicator(strokeWidth: 4.0)),
                    imageUrl: pokemon.spriteUrl),
                Text(pokemon.name,
                    style: TextStyle(
                        color: AppColors.SECONDARY_COLOR_DARK,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold)),
              ]),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _pokemonList.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: _buildListTileFront,
      ),
    );
  }
}
