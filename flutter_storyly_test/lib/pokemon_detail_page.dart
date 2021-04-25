import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'app_values.dart';
import 'data.dart';

class PokemonDetailPageState extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetailPageState({Key key, @required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR_DARK,
        title: Text(AppValues.TITLE),
      ),
      body: Center(
          child: Container(
              margin: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                child: Container(
                  color: Colors.white,
                  child: Column(children: [
                    CachedNetworkImage(
                        height: 300,
                        width: 300,
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
              ))),
    );
  }
}
