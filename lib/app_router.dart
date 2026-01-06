import 'package:flutter/material.dart';
import 'package:my_app/constants/strings.dart';
import 'package:my_app/presentation/screens/charachters_screen.dart';
import 'package:my_app/presentation/screens/character_details_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(builder: (context) => CharactersScreen());
      case characterDetailsScreen:
        return MaterialPageRoute(
          builder: (context) => CharacterDetailsScreen(),
        );
    }
    return null;
  }
}
