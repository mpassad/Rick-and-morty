class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final String url;
  final CharacterLocation origin;
  final CharacterLocation location;
  final List<String> episodes;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.url,
    required this.origin,
    required this.location,
    required this.episodes,
  });

  factory Character.fromDict(Map<dynamic, dynamic> dict) => Character(
        id: dict["id"],
        name: dict["name"],
        status: dict["status"],
        species: dict["species"],
        type: dict["type"],
        gender: dict["gender"],
        image: dict["image"],
        url: dict["url"],
        origin: CharacterLocation.fromDict(dict["origin"]),
        location: CharacterLocation.fromDict(dict["location"]),
        episodes: List<String>.from(dict["episode"].map((x) => x)),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
        "image": image,
        "url": url,
        "origin": origin.toDict(),
        "location": location.toDict(),
        "episode": List<dynamic>.from(episodes.map((x) => x)),
      };
}

class CharacterLocation {
  CharacterLocation({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory CharacterLocation.fromDict(Map<dynamic, dynamic> dict) =>
      CharacterLocation(
        name: dict["name"],
        url: dict["url"],
      );

  Map<dynamic, dynamic> toDict() => {
        "name": name,
        "url": url,
      };
}
