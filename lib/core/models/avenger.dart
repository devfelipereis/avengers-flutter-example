// To parse this JSON data, do
//
//     final avenger = avengerFromJson(jsonString);

import 'dart:convert';

List<Avenger> avengerFromJson(String str) =>
    new List<Avenger>.from(json.decode(str).map((x) => Avenger.fromJson(x)));

String avengerToJson(List<Avenger> data) =>
    json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Avenger {
  int id;
  String name;
  String imagePath;
  String description;
  int speed;
  int strength;
  int agility;

  Avenger({
    this.id,
    this.name,
    this.imagePath,
    this.description,
    this.speed,
    this.strength,
    this.agility,
  });

  factory Avenger.fromJson(Map<String, dynamic> json) => new Avenger(
        id: json["id"],
        name: json["name"],
        imagePath: json["imagePath"],
        description: json["description"],
        speed: json["speed"],
        strength: json["strength"],
        agility: json["agility"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imagePath": imagePath,
        "description": description,
        "speed": speed,
        "strength": strength,
        "agility": agility,
      };
}
