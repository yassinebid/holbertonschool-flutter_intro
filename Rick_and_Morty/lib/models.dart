class Character {
  String? name;
  String? img;
  int? id;

  Character(this.name, this.img, this.id);

  Character.fromJson(Map<String, dynamic> json) {
    Character(name = json['name'], img = json['image'], id = json['id']);
  }
}
