import 'dart:convert';

class ComplainToEntity {
  final int? id;
  final String? name;
  ComplainToEntity({
    this.id,
    this.name,
  });
  ComplainToEntity copyWith({
    int? id,
    String? name,
  }) {
    return ComplainToEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'ComplainToEntity {"id": $id, "name": $name, }';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory ComplainToEntity.fromMap(Map<String, dynamic> map) {
    return ComplainToEntity(
      id: map['id'] != null ? int.parse("${map['id']}") : null,
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ComplainToEntity.fromJson(String source) =>
      ComplainToEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant ComplainToEntity other) {
    if (identical(this, other)) return true;
    return id == other.id && name == other.name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}
