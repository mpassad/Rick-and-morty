import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/character.dart';

class CharacterCard {
  static Widget basic(Character char) {
    const radius = Radius.circular(24.0);

    return Card(
      margin: const EdgeInsets.all(8),
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: radius,
          ),
          child: avatar(char.image)),
    );
  }

  static Widget name(String name) {
    return Text(name);
  }

  static Widget status(String status) {
    return Text(status);
  }

  static Widget species(String species) {
    return Text(species);
  }

  static Widget avatar(String image) {
    return Image.network(
      image,
      alignment: Alignment.center,
      fit: BoxFit.fitHeight,
      width: double.infinity,
    );
  }
}
