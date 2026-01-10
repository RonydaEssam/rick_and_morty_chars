// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/business_logic/cubit/characters_cubit.dart';
import 'package:my_app/constants/strings.dart';
import 'package:my_app/data/models/character.dart';
import 'package:my_app/data/repository/characters_repo.dart';
import 'package:my_app/data/web_services/characters_web_services.dart';
import 'package:my_app/presentation/screens/charachters_screen.dart';
import 'package:my_app/presentation/screens/character_details_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: CharactersScreen(),
          ),
        );
      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (context) => CharacterDetailsScreen(
            character: character,
          ),
        );
    }
    return null;
  }
}
