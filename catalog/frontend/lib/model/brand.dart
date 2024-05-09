class Brand {
  num id;
  String name;

  Brand({required this.id, required this.name});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
  static Brand fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
    );
  }
}