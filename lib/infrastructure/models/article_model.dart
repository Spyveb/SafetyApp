// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'dart:convert';

ArticleModel articleModelFromJson(String str) => ArticleModel.fromJson(json.decode(str));

String articleModelToJson(ArticleModel data) => json.encode(data.toJson());

class ArticleModel {
  int? id;
  int? categoryId;
  String? title;
  String? subTitle;
  String? type;
  String? image;
  dynamic videoUrl;
  String? description;
  String? createdAt;
  String? updatedAt;

  ArticleModel({
    this.id,
    this.categoryId,
    this.title,
    this.subTitle,
    this.type,
    this.image,
    this.videoUrl,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json["id"],
        categoryId: json["category_id"],
        title: json["title"],
        subTitle: json["sub_title"],
        type: json["type"],
        image: json["image"],
        videoUrl: json["video_url"],
        description: json["description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "title": title,
        "sub_title": subTitle,
        "type": type,
        "image": image,
        "video_url": videoUrl,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
