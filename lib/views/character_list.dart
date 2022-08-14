import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/character.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/models/data_info.dart';
import 'dart:async';
import 'dart:convert';
import 'package:rick_and_morty_app/views/character_details_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _controller;
  bool isLoading = false;
  late Future<List<Character>> fetchChars;
  List<Character> characters = [];
  late DataInfo info;

  Future<List<Character>> fetchCharacters(String url) async {
    if (url == '') {
      return [];
    }
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse(url));

    List<Character> characterList = [];
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final List results = jsonDecode(response.body)['results'];
      final DataInfo _info =
          DataInfo.fromDict(jsonDecode(response.body)['info']);
      print(results[1]);
      for (var i = 0; i < results.length; i++) {
        characterList.add(Character.fromDict(results[i]));
      }
      setState(() {
        isLoading = false;
        info = _info;
        characters.addAll(characterList);
      });
      return characterList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return characterList;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchChars = fetchCharacters('https://rickandmortyapi.com/api/character');
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.atEdge && _controller.position.pixels != 0.0) {
        if (info.next != null) {
          fetchCharacters(info.next ?? '');
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        backgroundColor: Colors.grey[500],
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                controller: _controller,
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  final character = characters.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CharacterDetailsView(character: character)),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8),
                      child: Container(
                          color: Colors.grey[800],
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                character.image,
                                width: double.infinity,
                              ),
                              Text(
                                character.name,
                                style: const TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                              Text(
                                '${character.status} - ${character.species}',
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                              Text(
                                '${character.origin.name}',
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            ],
                          )),
                    ),
                  );
                },
              ),
            ),
            if (isLoading == true)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ));
  }
}
