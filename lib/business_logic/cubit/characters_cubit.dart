// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:my_app/data/models/character.dart';
import 'package:my_app/data/repository/characters_repo.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  final CharactersRepository charactersRepository;
  late List<Character> characters;

  List<Character> getAllCharacters() {
    charactersRepository.getAllCharacters().then(
      (characters) {
        emit(CharactersLoaded(characters));
        this.characters = characters;
      },
    );

    return characters;
  }
}
