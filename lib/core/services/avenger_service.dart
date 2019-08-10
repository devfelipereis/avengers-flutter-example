// import 'dart:convert';
// import 'package:dio/dio.dart';
import 'package:avengers/core/models/avenger.dart';

class AvengerService {
  // static const endpoint = 'someendpoint';

  Future<List<Avenger>> getAll() async {
    // Get user profile for id
    await new Future.delayed(const Duration(seconds: 2));
    // Response response = await Dio().get('someurl');
    // if (response.statusCode == 200) {
    //   return avengerFromJson(response.data);
    // } else {
    //   // If that call was not successful, throw an error.
    //   throw Exception('Failed to get the avengers');
    // }

    final List<Avenger> avengers = [
      Avenger(
        id: 1,
        name: "Iron Man",
        imagePath: "assets/images/avenger1.jpg",
        description: "Iron Man gets his superpowers from his metallic suit of armor and other technologies invented by his alter ego Tony Stark. Tony is a genius engineer and wealthy owner of a technology company. Tony built the Iron Man suit when he was kidnapped and suffered an injury to his heart.",
        speed: 869,
        strength: 600,
        agility: 150,
      ),
      Avenger(
        id: 2,
        name: "Black Widow",
        imagePath: "assets/images/avenger2.jpg",
        description: "Black Widow is a human, trained in the arts of espionage and martial arts, with specialities in hand-to-hand combat and interrogation. She has the athletic prowess of an Olympic class athlete and appears nearly superhuman at times.",
        speed: 730,
        strength: 500,
        agility: 174,
      ),
      Avenger(
        id: 3,
        name: "Doctor Strange",
        imagePath: "assets/images/avenger3.jpg",
        description: "Doctor Strange serves as the Sorcerer Supreme, the primary protector of Earth against magical and mystical threats. Inspired by stories of black magic and Chandu the Magician, Strange was created during the Silver Age of Comic Books to bring a different kind of character and themes of mysticism to Marvel Comics.",
        speed: 540,
        strength: 478,
        agility: 146,
      ),
      Avenger(
        id: 4,
        name: "Shuri",
        imagePath: "assets/images/avenger4.jpg",
        description: "Possessing one of the most brilliant minds in the world, the Black Panther’s sister, Princess Shuri, is also the chief science officer for Wakanda, a position she cherishes much more than her royal status.",
        speed: 100,
        strength: 1000,
        agility: 178,
      ),
      Avenger(
        id: 5,
        name: "Black Panther",
        imagePath: "assets/images/avenger5.jpg",
        description: "T’Challa is the king of the secretive and highly advanced African nation of Wakanda - as well as the powerful warrior known as the Black Panther.",
        speed: 550,
        strength: 450,
        agility: 389,
      ),
      Avenger(
        id: 6,
        name: "Scarlet Witch",
        imagePath: "assets/images/avenger6.jpg",
        description: "Notably powerful, Wanda Maximoff has fought both against and with the Avengers, attempting to hone her abilities and do what she believes is right to help the world.",
        speed: 150,
        strength: 1200,
        agility: 468,
      ),
      Avenger(
        id: 7,
        name: "Thor",
        imagePath: "assets/images/avenger7.jpg",
        description: "Thor Odinson is the Asgardian God of Thunder, superhero, self-proclaimed protector of Earth and the king of Asgard. Thor made a name for himself as the mightiest warrior on his homeworld and subsequently became well known for his actions on Earth, which included acting as a founding member of the Avengers.",
        speed: 300,
        strength: 1000,
        agility: 250,
      ),
      Avenger(
        id: 8,
        name: "Groot",
        description: "This sentient alien tree branches out of his comfort zone to help the Guardians of the Galaxy keep the people of the universe safe.",
        imagePath: "assets/images/avenger8.jpg",
        speed: 869,
        strength: 500,
        agility: 300,
      ),
    ];

    return avengers;
  }
}
