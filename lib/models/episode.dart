class Episode {
  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.url,
    required this.characters,
  });

  final int id;
  final String name;
  final String airDate;
  final String episode;
  final String url;
  final List<String> characters;

  factory Episode.fromDict(Map<dynamic, dynamic> dict) => Episode(
        id: dict["id"],
        name: dict["name"],
        airDate: dict["air_date"],
        episode: dict["episode"],
        characters: List<String>.from(dict["characters"].map((x) => x)),
        url: dict["url"],
      );

  Map<dynamic, dynamic> toDict() => {
        "id": id,
        "name": name,
        "air_date": airDate,
        "episode": episode,
        "characters": List<String>.from(characters.map((x) => x)),
        "url": url,
      };
}
