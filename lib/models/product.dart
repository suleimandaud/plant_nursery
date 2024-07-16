import 'dart:convert';

class Product {
  String id;
  String name;
  String imageUrl;
  String description;
  double price;
  String? Height;
  String? age;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    this.Height,
    this.age,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
      'Height': Height,
      'age': age,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      price: json['price'],
      Height: json['Height'],
      age: json['age'],
    );
  }
}
