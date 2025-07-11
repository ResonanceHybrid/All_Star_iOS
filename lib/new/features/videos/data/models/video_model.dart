import '../../domain/entities/video_entity.dart';

class VideoModel extends VideoEntity {
  VideoModel({
    super.id,
    super.name,
    super.slug,
    super.url,
    super.description,
    super.createdAt,
    super.updatedAt,
  });
  @override
  String toString() {
    return 'VideoModel {"id": $id, "name": $name, "slug": $slug, "url": $url, "description": $description, CreatedAt: $createdAt, UpdatedAt: $updatedAt}';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'url': url,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] != null ? int.parse("${map['id']}") : null,
      name: map['name'],
      slug: map['slug'],
      url: map['url'],
      description: map['description'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  static List<VideoModel> fromListMap(List<dynamic> data) {
    return data.map((e) => VideoModel.fromMap(e)).toList();
  }
}
