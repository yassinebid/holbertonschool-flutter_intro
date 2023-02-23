import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class EpisodesScreen extends StatelessWidget {
  final int id;
  const EpisodesScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  Future<List> fetchEpisodes(id) async {
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/episode'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var data = jsonDecode(response.body);
      List episodes = data['results'];
      List episodesCharater = [];
      String url = 'https://rickandmortyapi.com/api/character/${id}';
      for (var episode in episodes) {
        List listchara = episode['characters'];
        if (listchara.contains(url)) episodesCharater.add(episode['name']);
      }

      return episodesCharater;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Rick and Morty Episodes"),
      ),
      body: FutureBuilder(
          future: fetchEpisodes(id),
          builder: (context, snapshot) {
            List listEpisodes = snapshot.data!;

            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: listEpisodes.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return ListTile(
                      horizontalTitleGap: 0,
                      minVerticalPadding: 0,
                      minLeadingWidth: 0,
                      title: Text(
                        '* ${listEpisodes[index]}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
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
    );
  }
}
