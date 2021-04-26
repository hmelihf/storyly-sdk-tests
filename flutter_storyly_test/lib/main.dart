import 'package:flutter/material.dart';
import 'package:flutter_storyly_test/app_values.dart';
import 'package:flutter_storyly_test/widgets/pokemon_list_widget.dart';
import 'package:flutter_storyly_test/widgets/storyly_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      title: AppValues.TITLE,
      home: HomePageState(),
    );
  }
}

class HomePageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR_DARK,
        title: Text(AppValues.TITLE),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                child: StorylyWidget()),
            Expanded(child: PokemonListWidget()),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
      ),
    );
  }
}
