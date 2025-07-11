import '../../domain/entities/replies_entity.dart';

class RepliesModel extends RepliesEntity {
  RepliesModel({
    super.id,
    super.description,
    super.createdBy,
    super.role,
    super.createdAt,
  });
  @override
  String toString() {
    return 'RepliesModel {"id": $id, "description": $description, "createdBy": $createdBy, }';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'created_by': createdBy,
      "role": role,
    };
  }

  factory RepliesModel.fromMap(Map<String, dynamic> map) {
    return RepliesModel(
      id: map['id']?.toInt(),
      description: map['description'],
      createdBy: map['created_by'],
      role: map['role'],
      createdAt: map['created_at'],
    );
  }

  static fromListMap(List<dynamic> data) {
    List<RepliesModel> replies = [];
    for (var item in data) {
      replies.add(RepliesModel.fromMap(item));
    }
    return replies;
  }
}
