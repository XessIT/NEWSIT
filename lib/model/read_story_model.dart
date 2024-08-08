import 'package:json_annotation/json_annotation.dart';

part 'read_story_model.g.dart';

@JsonSerializable()
class NewsCategoryResponse {
  final int status;
  final String message;
  final List<NewsCategory> data;

  NewsCategoryResponse({required this.status, required this.message, required this.data});

  factory NewsCategoryResponse.fromJson(Map<String, dynamic> json) => _$NewsCategoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NewsCategoryResponseToJson(this);
}

@JsonSerializable()
class NewsCategory {
  final String id;
  final String name;
  final String description;
  final String? images;
  final List<Read_Story_News> news;

  NewsCategory({required this.id, required this.name, required this.description, this.images, required this.news});

  factory NewsCategory.fromJson(Map<String, dynamic> json) => _$NewsCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$NewsCategoryToJson(this);
}

@JsonSerializable()
class NewsStoryResponse {
  final int status;
  final String message;
  final List<Read_Story_News> data;

  NewsStoryResponse({required this.status, required this.message, required this.data});

  factory NewsStoryResponse.fromJson(Map<String, dynamic> json) => _$NewsStoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NewsStoryResponseToJson(this);
}

@JsonSerializable()
class Read_Story_News {
  final String id;
  @JsonKey(name: 'web_content')
  final String webContent;
  @JsonKey(name: 'news_card_images')
  final NewsCardImage? newsCardImage;
  @JsonKey(name: 'is_liked', defaultValue: false)
  final bool isLiked;
  @JsonKey(name: 'is_saved', defaultValue: false)
  final bool isSaved;
  @JsonKey(name: 'like_count', defaultValue: 0)
  final int likeCount;
  @JsonKey(name: 'save_count', defaultValue: 0)
  final int saveCount;

  Read_Story_News({
    required this.id,
    required this.webContent,
    this.newsCardImage,
    required this.isLiked,
    required this.isSaved,
    required this.likeCount,
    required this.saveCount,
  });

  factory Read_Story_News.fromJson(Map<String, dynamic> json) => _$Read_Story_NewsFromJson(json);
  Map<String, dynamic> toJson() => _$Read_Story_NewsToJson(this);
}

@JsonSerializable()
class NewsCardImage {
  @JsonKey(name: 'original_url')
  final String? originalUrl;
  @JsonKey(name: 'thumbnail_url')
  final String? thumbnailUrl;
  @JsonKey(name: 'low_res_url')
  final String? lowResUrl;

  NewsCardImage({
    this.originalUrl,
    this.thumbnailUrl,
    this.lowResUrl,
  });

  factory NewsCardImage.fromJson(Map<String, dynamic> json) => _$NewsCardImageFromJson(json);
  Map<String, dynamic> toJson() => _$NewsCardImageToJson(this);
}
