import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class News {
  final String? id;
  final String? web_content;
  final NewsCardImages? news_card_images;
  final List<Profile>? profiles;
  final List<Topic>? topics;
  final List<String>? tags;
  final bool? is_liked;
  final bool? is_saved;
  final int? like_count;
  final int? save_count;

  News({
    this.id,
    this.web_content,
    this.news_card_images,
    this.profiles,
    this.topics,
    this.tags,
    this.is_liked,
    this.is_saved,
    this.like_count,
    this.save_count,
  });

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}

@JsonSerializable()
class NewsCardImages {
  final String? original_key;
  final String? original_url;
  final String? thumbnail_key;
  final String? thumbnail_url;
  final String? low_res_key;
  final String? low_res_url;

  NewsCardImages({
    this.original_key,
    this.original_url,
    this.thumbnail_key,
    this.thumbnail_url,
    this.low_res_key,
    this.low_res_url,
  });

  factory NewsCardImages.fromJson(Map<String, dynamic> json) => _$NewsCardImagesFromJson(json);
  Map<String, dynamic> toJson() => _$NewsCardImagesToJson(this);
}

@JsonSerializable()
class Profile {
  final String? id;
  final String? name;
  final String? description;
  final String? image;

  Profile({
    this.id,
    this.name,
    this.description,
    this.image,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class Topic {
  final String? id;
  final String? name;
  final String? description;
  final String? image;

  Topic({
    this.id,
    this.name,
    this.description,
    this.image,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
  Map<String, dynamic> toJson() => _$TopicToJson(this);
}
