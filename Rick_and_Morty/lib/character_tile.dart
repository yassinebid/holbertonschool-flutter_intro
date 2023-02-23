import 'package:rick_and_morty/episodes_screen.dart';
import 'package:rick_and_morty/models.dart';
import 'package:flutter/material.dart';

class CharacterTile extends StatelessWidget {
  final Character character;
  const CharacterTile({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(character.img);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EpisodesScreen(id: character.id!)),
        );
      },
      child: GridTile(
        child: Container(
          //color: Colors.amberAccent,
          child: Image.network(
            character.img!,
            fit: BoxFit.cover,
          ),
        ),
        footer: Text(
          character.name!,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
