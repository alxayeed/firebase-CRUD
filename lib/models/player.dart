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

  factory Player.fromJson(Map<String, dynamic> json, String id) => Player(
        id: id,
        name: json['name'],
        age: json['age'].toString().isNotEmpty ? json['age'].toString() : 'N/A',
        country: json['country'],
        club: json['club'].toString().isNotEmpty ? json['club']: 'N/A',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age ?? '',
        'country': country,
        'club': club
      };
}
