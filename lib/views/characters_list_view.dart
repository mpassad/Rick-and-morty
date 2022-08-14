import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/character.dart';
import 'package:rick_and_morty_app/integrations/api.dart';
import 'package:rick_and_morty_app/views/character_details_view.dart';

class CharactersListView extends StatefulWidget {
  const CharactersListView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CharactersListView> createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersListView> {
  bool isLoading = false;
  late Future<List<Character>> futureCharacters;
  List<Character> charactersStore = [];
  void _incrementCounter() {
    setState(() {
      isLoading = false;
    });
  }

  void appendCharacters(List<Character> data) {
    setState(() {
      charactersStore.addAll(data);
    });
  }

  void _loadingDone() {
    setState(() {
      isLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _incrementCounter();
    futureCharacters = API.fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    Radius radius = const Radius.circular(30.0);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification.metrics.atEdge) {
              if (notification.metrics.pixels == 0) {
                print('At top');
              } else {
                futureCharacters = API.fetchCharacters();
              }
            }
            return true;
          },
          child: futureBuilderComponent(context, futureCharacters),
        ));
  }

  SliverList sliverListView(List<Character> data) {
    int countData;
    countData = data.length;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CharacterDetailsView(character: data[index])),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(16),
              child: Container(
                  color: Colors.grey[800],
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Image.network(
                        data[index].image,
                        width: double.infinity,
                      ),
                      Text(
                        data[index].name,
                        style: const TextStyle(fontSize: 30),
                      ),
                    ],
                  )),
            ),
          );
        },
        childCount: countData,
      ),
    );
  }

  FutureBuilder<List<Character>> futureBuilderComponent(context, futureData) {
    return FutureBuilder<List<Character>>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            List<Character>? chars = snapshot.data;
            if (chars != null) {
              return CustomScrollView(
                  slivers: [sliverListView(charactersStore)]);
            }
          } else {
            return const Text('No available data');
          }
        } else if (snapshot.hasError) {
          return const Center(
              child: Text('There was an error fetching the data.'));
        }
        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
