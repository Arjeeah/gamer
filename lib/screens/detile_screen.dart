import 'package:anime_app/models/game_model.dart';
import 'package:anime_app/providers/dark_mode_provider.dart';
import 'package:anime_app/providers/game_provider.dart';
import 'package:anime_app/widgets/game_card.dart';
import 'package:anime_app/widgets/reqiuremnt_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetileScreen extends StatefulWidget {
  const DetileScreen({super.key, required this.gameModel});
  final GameModel gameModel;

  @override
  State<DetileScreen> createState() => _DetileScreenState();
}

class _DetileScreenState extends State<DetileScreen> {
  @override
  void initState() {
    Provider.of<GameProvider>(context, listen: false)
        .featchone(widget.gameModel.id);
    super.initState();
  }

  @override
  // ignore: override_on_non_overriding_member, no_leading_underscores_for_local_identifiers
  _launchUrl(Uri _url) async {
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw Exception('Could not launch $_url');
    }
  }

  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer2<GameProvider, DarkModeProvider>(
        builder: (context, gameConsumer, darkmodeconsumer, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            gameConsumer.onegameModel == null
                ? 'loding...'
                : gameConsumer.onegameModel!.genre.toString(),
            style: TextStyle(
                color: darkmodeconsumer.isdark ? Colors.white : Colors.black),
          ),
        ),
        body: gameConsumer.onegameModel == null && gameConsumer.isLoad == true
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.black,
                  size: 200,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                        child: Text(gameConsumer.onegameModel!.title,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: darkmodeconsumer.isdark
                                    ? Colors.white
                                    : Colors.black)),
                      ),
                      // ignore: avoid_unnecessary_containers
                      Stack(
                        children: [
                          SizedBox(
                            height: 400,
                            child: Image.network(
                              gameConsumer.onegameModel!.thumbnail,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              top: 16,
                              right: 16,
                              child: Row(
                                children: [
                                  if (gameConsumer.onegameModel!.platform
                                      .contains("Windows"))
                                    const Icon(
                                      FontAwesomeIcons.computer,
                                      color: Colors.black,
                                    ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  if (gameConsumer.onegameModel!.platform
                                      .contains("Web"))
                                    const Icon(
                                      FontAwesomeIcons.globe,
                                      color: Colors.black,
                                    )
                                ],
                              ))
                        ],
                      ),

                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        gameConsumer.onegameModel!.description,
                        maxLines: showMore ? 50 : 3,
                        style: TextStyle(
                            fontSize: 20,
                            color: darkmodeconsumer.isdark
                                ? Colors.white
                                : Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showMore = !showMore;
                          });
                        },
                        child: Text(
                          showMore ? "Show less" : "Show More",
                          style: TextStyle(
                              color: darkmodeconsumer.isdark
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8),
                          itemCount:
                              gameConsumer.onegameModel?.screenshots.length,
                          itemBuilder: (context, index) {
                            return Image.network(
                                fit: BoxFit.cover,
                                gameConsumer
                                    .onegameModel!.screenshots[index].image);
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      if (gameConsumer
                              .onegameModel!.minimumSystemRequirements !=
                          null)
                        ReqiuremntCard(
                            min: gameConsumer
                                .onegameModel!.minimumSystemRequirements!),

                      SizedBox(
                        height: size.height * 0.30,
                        child: ListView.builder(
                            itemCount: gameConsumer.simalr.length,
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 100,
                                width: size.width * 0.5,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: GameCard(
                                    gameModel: gameConsumer.simalr[index],
                                  ),
                                ),
                              );
                            }),
                      ),
                      Center(
                          child: OutlinedButton(
                        onPressed: () {
                          _launchUrl(
                              Uri.parse(gameConsumer.onegameModel!.gameUrl));
                        },
                        child: const Text("click"),
                      )),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}
