class Character {
  late int characterId;
  late String name;
  late String species;
  late String speciesType;
  late String gender;
  late String lifeStatus;
  late String image;
  late Location origin;
  late Location location;
  late List<String> episodesApperance;

  Character.fromJson(Map<String, dynamic> json) {
    characterId = json['id'];
    name = json['name'];
    species = json['species'];
    speciesType = json['type'];
    gender = json['gender'];
    lifeStatus = json['status'];
    image = json['image'];
    origin = json['origin'];
    location = json['location'];
    episodesApperance = json['episode'];
  }
}

class Location {
  late String name;
  late String url;

  Location(this.name, this.url);

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}
