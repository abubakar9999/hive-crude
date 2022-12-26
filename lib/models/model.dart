import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'model.g.dart';

List<Model> modelFromJson(String str) =>
    List<Model>.from(json.decode(str).map((x) => Model.fromJson(x)));

String modelToJson(List<Model> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 0)
class Model {
  Model({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  double price;
  @HiveField(3)
  String description;
  @HiveField(4)
  String category;
  @HiveField(5)
  String image;
  @HiveField(6)
  Rating rating;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: Rating.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating.toJson(),
      };
}

enum Category { MEN_S_CLOTHING, JEWELERY, ELECTRONICS, WOMEN_S_CLOTHING }

class Rating {
  Rating({
    required this.rate,
    required this.count,
  });

  double rate;
  int count;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"].toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}
