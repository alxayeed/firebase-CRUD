class Player {
  String? id;
  String name;
  String? age;
  String country;
  String? club;

  Player(
      {this.id,
      required this.name,
      this.age,
      required this.country,
      this.club});

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        country: json['country'],
        club: json['club'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age ?? '',
        'country': country,
        'club': club
      };
}
