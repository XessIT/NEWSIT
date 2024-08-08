// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      id: json['id'] as String?,
      web_content: json['web_content'] as String?,
      news_card_images: json['news_card_images'] == null
          ? null
          : NewsCardImages.fromJson(
              json['news_card_images'] as Map<String, dynamic>),
      profiles: (json['profiles'] as List<dynamic>?)
          ?.map((e) => Profile.fromJson(e as Map<String, dynamic>))
          .toList(),
      topics: (json['topics'] as List<dynamic>?)
          ?.map((e) => Topic.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      is_liked: json['is_liked'] as bool?,
      is_saved: json['is_saved'] as bool?,
      like_count: (json['like_count'] as num?)?.toInt(),
      save_count: (json['save_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'id': instance.id,
      'web_content': instance.web_content,
      'news_card_images': instance.news_card_images,
      'profiles': instance.profiles,
      'topics': instance.topics,
      'tags': instance.tags,
      'is_liked': instance.is_liked,
      'is_saved': instance.is_saved,
      'like_count': instance.like_count,
      'save_count': instance.save_count,
    };

NewsCardImages _$NewsCardImagesFromJson(Map<String, dynamic> json) =>
    NewsCardImages(
      original_key: json['original_key'] as String?,
      original_url: json['original_url'] as String?,
      thumbnail_key: json['thumbnail_key'] as String?,
      thumbnail_url: json['thumbnail_url'] as String?,
      low_res_key: json['low_res_key'] as String?,
      low_res_url: json['low_res_url'] as String?,
    );

Map<String, dynamic> _$NewsCardImagesToJson(NewsCardImages instance) =>
    <String, dynamic>{
      'original_key': instance.original_key,
      'original_url': instance.original_url,
      'thumbnail_key': instance.thumbnail_key,
      'thumbnail_url': instance.thumbnail_url,
      'low_res_key': instance.low_res_key,
      'low_res_url': instance.low_res_url,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
    };

Topic _$TopicFromJson(Map<String, dynamic> json) => Topic(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
    };
