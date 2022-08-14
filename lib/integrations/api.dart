import 'package:rick_and_morty_app/models/character.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  Future<List<dynamic>> get(endpoint) async {
    List<dynamic> data = [];
    return data;
  }

  static Future<List<Character>> fetchCharacters() async {
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));

    List<Character> characterList = [];
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final List results = jsonDecode(response.body)['results'];
      // final DataInfo info = DataInfo.fromDict(jsonDecode(response.body)['info']);
      print(results[1]);
      for (var i = 0; i < results.length; i++) {
        characterList.add(Character.fromDict(results[i]));
      }
      return characterList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return characterList;
    }
  }

  static Future<Character?> fetchCharacter(url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> results = jsonDecode(response.body);
      Character character = Character.fromDict(results);
      return character;
    } else {
      return null;
    }
  }
}
