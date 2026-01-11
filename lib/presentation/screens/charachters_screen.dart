import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../../constants/app_colors.dart';
import '../../data/models/character.dart';
import '../widgets/character_item.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  List<Character> searchedForCharacters = [];
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget _buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(
        color: AppColors.grey,
        fontWeight: FontWeight.w500,
        fontSize: 20.sp,
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: AppColors.grey,
      decoration: InputDecoration(
        hintText: 'Find a character ...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: AppColors.grey, fontSize: 12.sp),
      ),
      style: TextStyle(color: AppColors.grey, fontSize: 12.sp),
      onChanged: (searchedText) => filteringText(searchedText),
    );
  }

  void filteringText(String searchedText) {
    searchedForCharacters = allCharacters
        .where(
          (character) => character.name.toLowerCase().startsWith(searchedText),
        )
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _stopSearching();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.clear,
            color: AppColors.grey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(
            Icons.manage_search_sharp,
            color: AppColors.grey,
            size: 20.sp,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(
      context,
    )!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    setState(() {
      _searchTextController.clear();
      _isSearching = false;
    });
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidget();
        } else {
          return Center(
            child: CircularProgressIndicator(color: AppColors.bluish),
          );
        }
      },
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.grey,
        child: Column(
          children: [
            GridView.builder(
              itemCount: _searchTextController.text.isEmpty
                  ? allCharacters.length
                  : searchedForCharacters.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return CharacterItem(
                  character: _searchTextController.text.isEmpty
                      ? allCharacters[index]
                      : searchedForCharacters[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        margin: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Can\'t connect right now....\nPlease check your Connection.',
              style: TextStyle(
                fontSize: 18.sp,
                color: AppColors.bluish,
                fontWeight: FontWeight.w500,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.h),
            Image.asset(
              'assets/images/connection_lost.png',
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bluish,
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
        leading: _isSearching ? BackButton(color: AppColors.grey) : null,
      ),
      body: OfflineBuilder(
        connectivityBuilder: (context, connectivity, child) {
          final bool connected = !connectivity.contains(
            ConnectivityResult.none,
          );
          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
