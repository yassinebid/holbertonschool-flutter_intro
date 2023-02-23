import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/models.dart';

import 'character_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List> fetchBbCharacters() async {
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var data = jsonDecode(response.body);
      List characters = data['results'];

      return characters;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(centerTitle: false, title: Text('Rick and Morty Characters')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: fetchBbCharacters(),
            builder: (context, snapshot) {
              List listCharaters = snapshot.data!;
              print(listCharaters);

              if (snapshot.hasData) {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 400,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: listCharaters.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return CharacterTile(
                        character: Character.fromJson(listCharaters[index]),
                      );
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error'),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
