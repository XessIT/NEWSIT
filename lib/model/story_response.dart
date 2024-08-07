import 'package:json_annotation/json_annotation.dart';

part 'story_response.g.dart';

@JsonSerializable(explicitToJson: true)
class NewsResponse {
  final int status;
  final String message;
  final List<CategoryData> data;

  NewsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) => _$NewsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CategoryData {
  final String id;
  final String name;
  final String? description;
  final MultilingualNames multilingualNames;
  final MultilingualDescriptions multilingualDescriptions;
  final List<News> news;

  CategoryData({
    required this.id,
    required this.name,
    this.description,
    required this.multilingualNames,
    required this.multilingualDescriptions,
    required this.news,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => _$CategoryDataFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MultilingualNames {
  final String en;
  final String ta;

  MultilingualNames({
    required this.en,
    required this.ta,
  });

  factory MultilingualNames.fromJson(Map<String, dynamic> json) => _$MultilingualNamesFromJson(json);
  Map<String, dynamic> toJson() => _$MultilingualNamesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MultilingualDescriptions {
  final String en;
  final String ta;

  MultilingualDescriptions({
    required this.en,
    required this.ta,
  });

  factory MultilingualDescriptions.fromJson(Map<String, dynamic> json) => _$MultilingualDescriptionsFromJson(json);
  Map<String, dynamic> toJson() => _$MultilingualDescriptionsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class News {
  final String id;
  final String webContent;
  final NewsCardImages newsCardImages;
  final bool isLiked;
  final bool isSaved;

  News({
    required this.id,
    required this.webContent,
    required this.newsCardImages,
    required this.isLiked,
    required this.isSaved,
  });

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NewsCardImages {
  final String originalKey;
  final String originalUrl;
  final String thumbnailKey;
  final String thumbnailUrl;
  final String lowResKey;
  final String lowResUrl;

  NewsCardImages({
    required this.originalKey,
    required this.originalUrl,
    required this.thumbnailKey,
    required this.thumbnailUrl,
    required this.lowResKey,
    required this.lowResUrl,
  });

  factory NewsCardImages.fromJson(Map<String, dynamic> json) => _$NewsCardImagesFromJson(json);
  Map<String, dynamic> toJson() => _$NewsCardImagesToJson(this);
}
