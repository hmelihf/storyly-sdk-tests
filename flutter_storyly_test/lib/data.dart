import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Pokemon {
  Pokemon({this.name, this.url, this.id});

  String name;
  String url;
  String id;
  String get spriteUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  static String parseId(String url) {
    var uri = Uri.parse(url);
    return uri.pathSegments[3];
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
        name: capitalize(json['name']),
        url: json['url'],
        id: parseId(json['url']));
  }
}

String capitalize(String str) {
  return (str.length > 0) ? "${str[0].toUpperCase()}${str.substring(1)}" : "";
}

Future<List<Pokemon>> fetchPokemons() async {
  final response = await http.get(Uri.https(
      'pokeapi.co', 'api/v2/pokemon', {'offset': "0", 'limit': "10000"}));

  if (response.statusCode == 200) {
    var obj = json.decode(response.body);
    Iterable list = obj['results'];
    return list.map((e) => Pokemon.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load pokemons');
  }
}

void onFailShowSnackBar(
    BuildContext context, String msg, void Function() onRefresh) {
  var scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(msg),
      action: SnackBarAction(
          label: "refresh",
          onPressed: () {
            scaffold.hideCurrentSnackBar();
            onRefresh();
          }),
      duration: Duration(milliseconds: 1500),
    ),
  );
}
