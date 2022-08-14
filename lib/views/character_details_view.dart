import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/character.dart';
import 'package:rick_and_morty_app/integrations/api.dart';

class CharacterDetailsView extends StatefulWidget {
  const CharacterDetailsView({Key? key, required this.character})
      : super(key: key);

  final Character character;

  @override
  State<CharacterDetailsView> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetailsView> {
  late Future<Character?> futureCharacter;

  @override
  void initState() {
    super.initState();
    futureCharacter = API.fetchCharacter(widget.character.url);
  }

  Widget divider({heightConst = 20.0}) {
    return Divider(
      height: heightConst,
      thickness: 1,
    );
  }

  Widget label(String value) {
    return Text(
        style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        '$value:');
  }

  Widget textView(String value) {
    return Text(
        style: const TextStyle(fontSize: 20.0),
        '${value == '' || value == null ? 'N/A' : value}');
  }

  Widget valueSet(String labelMessage, String value) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [label(labelMessage), textView(value)]);
  }

  Widget avatar(String value) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: NetworkImage(value),
        ),
      ),
    );
  }

  Widget baseView(Character character) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        avatar(character.image),
        valueSet('First Appearance', character.episodes[0]),
        valueSet('Last Appearance', character.episodes.last),
        divider(),
        valueSet('Status', character.status),
        valueSet('Species', character.species),
        valueSet('Type', character.type),
        valueSet('Gender', character.gender),
        divider(),
        valueSet('Origin', character.origin.name),
        valueSet('Location', character.location.name),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Character character = widget.character;
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: futureBuilderComponent(context, futureCharacter),
    );
  }

  FutureBuilder<Character?> futureBuilderComponent(context, futureData) {
    return FutureBuilder<Character?>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            Character? character = snapshot.data;
            if (character != null) {
              return SingleChildScrollView(child: baseView(character));
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
