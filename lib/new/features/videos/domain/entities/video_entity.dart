import 'dart:convert';

class VideoEntity {
  final int? id;
  final String? name;
  final String? slug;
  final String? url;
  final String? description;
  final String? createdAt;
  final String? updatedAt;
  VideoEntity({
    this.id,
    this.name,
    this.slug,
    this.url,
    this.description,
    this.createdAt,
    this.updatedAt,
  });
  VideoEntity copyWith({
    int? id,
    String? name,
    String? slug,
    String? url,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    return VideoEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      url: url ?? this.url,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'VideoEntity {"id": $id, "name": $name, "slug": $slug, "url": $url, "description": $description, CreatedAt: $createdAt, UpdatedAt: $updatedAt}';
  }

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

  factory VideoEntity.fromMap(Map<String, dynamic> map) {
    return VideoEntity(
      id: map['id'] != null ? int.parse("${map['id']}") : null,
      name: map['name'],
      slug: map['slug'],
      url: map['url'],
      description: map['description'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoEntity.fromJson(String source) =>
      VideoEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant VideoEntity other) {
    if (identical(this, other)) return true;
    return id == other.id &&
        name == other.name &&
        slug == other.slug &&
        url == other.url &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        description == other.description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        slug.hashCode ^
        url.hashCode ^
        description.hashCode;
  }
}
