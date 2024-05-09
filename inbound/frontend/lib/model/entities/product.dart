class Product {
  int id;
  String? name;
  int? quantity;
  Product(
      {required this.id,
        required this.name,
        required this.quantity});

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        quantity = json['quantity'];
}