import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/models/character.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({super.key, required this.character});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.grey,
      leading: BackButton(color: AppColors.bluish),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name,
          style: TextStyle(
            color: AppColors.bluish,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        background: Hero(
          tag: character.characterId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String info) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.bluish,
          ),
          textAlign: TextAlign.start,
          maxLines: 1,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          info,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.bluish,
          ),
          textAlign: TextAlign.start,
          maxLines: 1,
        ),
        SizedBox(height: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Species', character.species),
                      character.speciesType.isEmpty
                          ? Container()
                          : characterInfo('Type', character.speciesType),
                      characterInfo('Gender', character.gender),
                      characterInfo('Status', character.lifeStatus),
                      characterInfo(
                        'Appeared In',
                        '${character.episodesApperance.length.toString()} episodes',
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                SizedBox(height: 400),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
