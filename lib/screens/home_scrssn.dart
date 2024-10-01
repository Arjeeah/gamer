import 'package:anime_app/helpers/const.dart';
import 'package:anime_app/providers/dark_mode_provider.dart';
import 'package:anime_app/providers/game_provider.dart';
import 'package:anime_app/widgets/game_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScrssn extends StatefulWidget {
  const HomeScrssn({super.key});

  @override
  State<HomeScrssn> createState() => _HomeScrssnState();
}

class _HomeScrssnState extends State<HomeScrssn> {
  @override
  void initState() {
    Provider.of<GameProvider>(context, listen: false).featch("all");
    super.initState();
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer2<GameProvider, DarkModeProvider>(builder: (
      context,
      gameConsumer,
      darkmodeconsumer,
      _,
    ) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Gamer",
                style: TextStyle(
                    color:
                        darkmodeconsumer.isdark ? Colors.white : Colors.black),
              ),
              IconButton(
                onPressed: () {
                  darkmodeconsumer.switchmode();
                },
                icon: darkmodeconsumer.isdark
                    ? const Icon(Icons.light_mode)
                    : const Icon(Icons.dark_mode),
                color: darkmodeconsumer.isdark ? Colors.white : Colors.black,
              )
            ],
          ),
        ),
        body: Center(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
                itemCount: gameConsumer.isload ? 6 : gameConsumer.games.length,
                itemBuilder: (context, index) {
                  return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: gameConsumer.isload
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Shimmer.fromColors(
                                  baseColor: Colors.white24,
                                  highlightColor: Colors.black45,
                                  child: Container(
                                    color: Colors.white,
                                    height: double.infinity,
                                    width: double.infinity,
                                  )),
                            )
                          : GameCard(gameModel: gameConsumer.games[index]));
                })),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: blue,
          showUnselectedLabels: false,
          selectedLabelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold),
          currentIndex: index,
          onTap: (crentindex) {
            setState(() {
              index = crentindex;
            });
            Provider.of<GameProvider>(context, listen: false).featch(index == 0
                ? "all"
                : index == 1
                    ? "pc"
                    : "browser");
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.airbnb), label: "All"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.computer), label: "PC"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.globe), label: "WEP"),
          ],
        ),
      );
    });
  }
}
