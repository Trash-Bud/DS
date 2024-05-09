class Product {
  num? id;
  num? brandId;
  String name;
  String? description;
  String? season;
  String supplier;
  String type;
  String family;
  String? subfamily;
  List<num>? variantsIds;

  Product(
      {this.id,
      this.brandId,
      required this.name,
      this.description,
      this.season,
      required this.supplier,
      required this.type,
      required this.family,
      this.subfamily,
      this.variantsIds});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'season': season,
      'supplier': supplier,
      'type': type,
      'family': family,
      'subFamily': subfamily,
      'variantsIds': variantsIds,
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      season: json['season'],
      supplier: json['supplier'],
      type: json['type'],
      family: json['family'],
      subfamily: json['subFamily'],
      variantsIds: json['variantsIds'] != null
          ? (json['variantsIds'] as List).cast<num>()
          : null,
    );
  }
}
