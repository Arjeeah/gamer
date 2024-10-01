import 'dart:convert';

import 'package:anime_app/models/game_model.dart';
import 'package:anime_app/models/one_game_model.dart';
import 'package:anime_app/services/api.dart';
import 'package:flutter/foundation.dart';

class GameProvider with ChangeNotifier {
  bool isload = false;
  Api api = Api();

  List<GameModel> games = [];
  featch(String paltform) async {
    isload = true;
    notifyListeners();
    games.clear();
    final response = await api
        .get("https://www.freetogame.com/api/games?platform=$paltform");

    if (response.statusCode == 200) {
      var decodeddata = json.decode(response.body);
      for (var i in decodeddata) {
        games.add(GameModel.fromJson(i));
      }
    }

    isload = false;
    notifyListeners();
  }

  OnegameModel? onegameModel;
  bool isLoad = false;
  featchone(int id) async {
    isLoad = true;
    notifyListeners();

    final response =
        await api.get("https://www.freetogame.com/api/game?id=$id");
    if (response.statusCode == 200) {
      var decodeddata = json.decode(response.body);
      onegameModel = OnegameModel.fromJson(decodeddata);
    }

    catfeatch(onegameModel!.genre);
    isLoad = false;
    notifyListeners();
  }

  List<GameModel> simalr = [];
  catfeatch(String paltform) async {
    isLoad = true;
    notifyListeners();
    simalr.clear();
    final response = await api
        .get("https://www.freetogame.com/api/games?category=$paltform");
    if (kDebugMode) {
      print("Stutse Code${response.statusCode}");
    }
    if (kDebugMode) {
      print("Stutse Code${response.body}");
    }
    if (response.statusCode == 200) {
      var decodeddata = json.decode(response.body);
      for (var i in decodeddata) {
        simalr.add(GameModel.fromJson(i));
      }
    }

    isLoad = false;
    notifyListeners();
  }
}
