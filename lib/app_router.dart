import 'package:flutter/material.dart';
import 'package:my_app/presentation/screens/charachters.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => CharachtersScreen());
    }
    return null;
  }
}
