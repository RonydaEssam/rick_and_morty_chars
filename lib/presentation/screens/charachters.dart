import 'package:flutter/material.dart';

class CharachtersScreen extends StatelessWidget {
  const CharachtersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rick and Morty characters')),
      body: Text('Characters'),
    );
  }
}
