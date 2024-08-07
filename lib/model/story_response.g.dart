// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsResponse _$NewsResponseFromJson(Map<String, dynamic> json) => NewsResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => CategoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewsResponseToJson(NewsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

CategoryData _$CategoryDataFromJson(Map<String, dynamic> json) => CategoryData(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      multilingualNames: MultilingualNames.fromJson(
          json['multilingualNames'] as Map<String, dynamic>),
      multilingualDescriptions: MultilingualDescriptions.fromJson(
          json['multilingualDescriptions'] as Map<String, dynamic>),
      news: (json['news'] as List<dynamic>)
          .map((e) => News.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryDataToJson(CategoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'multilingualNames': instance.multilingualNames.toJson(),
      'multilingualDescriptions': instance.multilingualDescriptions.toJson(),
      'news': instance.news.map((e) => e.toJson()).toList(),
    };

MultilingualNames _$MultilingualNamesFromJson(Map<String, dynamic> json) =>
    MultilingualNames(
      en: json['en'] as String,
      ta: json['ta'] as String,
    );

Map<String, dynamic> _$MultilingualNamesToJson(MultilingualNames instance) =>
    <String, dynamic>{
      'en': instance.en,
      'ta': instance.ta,
    };

MultilingualDescriptions _$MultilingualDescriptionsFromJson(
        Map<String, dynamic> json) =>
    MultilingualDescriptions(
      en: json['en'] as String,
      ta: json['ta'] as String,
    );

Map<String, dynamic> _$MultilingualDescriptionsToJson(
        MultilingualDescriptions instance) =>
    <String, dynamic>{
      'en': instance.en,
      'ta': instance.ta,
    };

News _$NewsFromJson(Map<String, dynamic> json) => News(
      id: json['id'] as String,
      webContent: json['webContent'] as String,
      newsCardImages: NewsCardImages.fromJson(
          json['newsCardImages'] as Map<String, dynamic>),
      isLiked: json['isLiked'] as bool,
      isSaved: json['isSaved'] as bool,
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'id': instance.id,
      'webContent': instance.webContent,
      'newsCardImages': instance.newsCardImages.toJson(),
      'isLiked': instance.isLiked,
      'isSaved': instance.isSaved,
    };

NewsCardImages _$NewsCardImagesFromJson(Map<String, dynamic> json) =>
    NewsCardImages(
      originalKey: json['originalKey'] as String,
      originalUrl: json['originalUrl'] as String,
      thumbnailKey: json['thumbnailKey'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      lowResKey: json['lowResKey'] as String,
      lowResUrl: json['lowResUrl'] as String,
    );

Map<String, dynamic> _$NewsCardImagesToJson(NewsCardImages instance) =>
    <String, dynamic>{
      'originalKey': instance.originalKey,
      'originalUrl': instance.originalUrl,
      'thumbnailKey': instance.thumbnailKey,
      'thumbnailUrl': instance.thumbnailUrl,
      'lowResKey': instance.lowResKey,
      'lowResUrl': instance.lowResUrl,
    };
