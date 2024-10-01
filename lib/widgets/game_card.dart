import 'package:anime_app/models/game_model.dart';
import 'package:anime_app/screens/detile_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GameCard extends StatelessWidget {
  const GameCard({super.key, required this.gameModel});
  final GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetileScreen(
                      gameModel: gameModel,
                    )));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridTile(
            header: Container(
              height: 42,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black38, Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gameModel.genre.toString().substring(6),
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    Icon(
                      gameModel.platform.toString().contains("PC")
                          ? FontAwesomeIcons.computer
                          : FontAwesomeIcons.globe,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            footer: Container(
              height: 50,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.black45,
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gameModel.publisher,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 10,
                          color: Colors.white),
                    ),
                    AutoSizeText(
                      gameModel.title,
                      maxFontSize: 18,
                      maxLines: 1,
                      minFontSize: 12,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            child: Container(
              child: Image.network(gameModel.thumbnail, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}
