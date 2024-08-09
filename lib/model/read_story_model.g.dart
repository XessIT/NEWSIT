// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsCategoryResponse _$NewsCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    NewsCategoryResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => NewsCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewsCategoryResponseToJson(
        NewsCategoryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

NewsCategory _$NewsCategoryFromJson(Map<String, dynamic> json) => NewsCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      images: json['images'] as String?,
      news: (json['news'] as List<dynamic>)
          .map((e) => Read_Story_News.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewsCategoryToJson(NewsCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'images': instance.images,
      'news': instance.news,
    };

NewsStoryResponse _$NewsStoryResponseFromJson(Map<String, dynamic> json) =>
    NewsStoryResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Read_Story_News.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewsStoryResponseToJson(NewsStoryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Read_Story_News _$Read_Story_NewsFromJson(Map<String, dynamic> json) =>
    Read_Story_News(
      id: json['id'] as String,
      webContent: json['web_content'] as String,
      newsCardImage: json['news_card_images'] == null
          ? null
          : NewsCardImage.fromJson(
              json['news_card_images'] as Map<String, dynamic>),
      isLiked: json['is_liked'] as bool? ?? false,
      isSaved: json['is_saved'] as bool? ?? false,
      likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
      saveCount: (json['save_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$Read_Story_NewsToJson(Read_Story_News instance) =>
    <String, dynamic>{
      'id': instance.id,
      'web_content': instance.webContent,
      'news_card_images': instance.newsCardImage,
      'is_liked': instance.isLiked,
      'is_saved': instance.isSaved,
      'like_count': instance.likeCount,
      'save_count': instance.saveCount,
    };

NewsCardImage _$NewsCardImageFromJson(Map<String, dynamic> json) =>
    NewsCardImage(
      originalUrl: json['original_url'] as String?,
      thumbnailUrl: json['thumbnail_url'] as String?,
      lowResUrl: json['low_res_url'] as String?,
    );

Map<String, dynamic> _$NewsCardImageToJson(NewsCardImage instance) =>
    <String, dynamic>{
      'original_url': instance.originalUrl,
      'thumbnail_url': instance.thumbnailUrl,
      'low_res_url': instance.lowResUrl,
    };
