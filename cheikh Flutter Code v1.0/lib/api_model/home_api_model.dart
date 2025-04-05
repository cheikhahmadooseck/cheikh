// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  int? responseCode;
  bool? result;
  String? message;
  General? general;
  CusRating? cusRating;
  List<CategoryList>? categoryList;

  HomeModel({
    this.responseCode,
    this.result,
    this.message,
    this.general,
    this.cusRating,
    this.categoryList,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    responseCode: json["ResponseCode"],
    result: json["Result"],
    message: json["message"],
    general: json["general"] == null ? null : General.fromJson(json["general"]),
    cusRating: json["cus_rating"] == null ? null : CusRating.fromJson(json["cus_rating"]),
    categoryList: json["category_list"] == null ? [] : List<CategoryList>.from(json["category_list"]!.map((x) => CategoryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "Result": result,
    "message": message,
    "general": general?.toJson(),
    "cus_rating": cusRating?.toJson(),
    "category_list": categoryList == null ? [] : List<dynamic>.from(categoryList!.map((x) => x.toJson())),
  };
}

class CategoryList {
  int? id;
  String? image;
  String? name;
  String? description;
  String? bidding;
  String? role;

  CategoryList({
    this.id,
    this.image,
    this.name,
    this.description,
    this.bidding,
    this.role,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    description: json["description"],
    bidding: json["bidding"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "description": description,
    "bidding": bidding,
    "role": role,
  };
}

class CusRating {
  int? id;
  num? totReview;
  num? avgStar;

  CusRating({
    this.id,
    this.totReview,
    this.avgStar,
  });

  factory CusRating.fromJson(Map<String, dynamic> json) => CusRating(
    id: json["id"],
    totReview: json["tot_review"],
    avgStar: json["avg_star"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tot_review": totReview,
    "avg_star": avgStar,
  };
}

class General {
  String? siteCurrency;

  General({
    this.siteCurrency,
  });

  factory General.fromJson(Map<String, dynamic> json) => General(
    siteCurrency: json["site_currency"],
  );

  Map<String, dynamic> toJson() => {
    "site_currency": siteCurrency,
  };
}
