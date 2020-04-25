import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({this.favorites});
  final Set<String> favorites;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Page'),
      ),
      body: ListView(
        children: favorites
            .map((url) => ListTile(
                  title: Text(url),
                  onTap: () => Navigator.pop(context),
                ))
            .toList(),
      ),
    );
  }
}
