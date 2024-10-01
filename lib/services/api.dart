import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

// "https://www.freetogame.com/api/games?platform=$paltform"
class Api {
   Future<Response> get(String uri) async {
    var response = await http.get(Uri.parse(uri));
    if (kDebugMode) {
      print("get on$uri");

      print("Stutse Code${response.statusCode}");
      print("Stutse body${response.body}");
    }

    return response;
  }
}
