import '../../domain/entities/section_entity.dart';

class SectionModel extends SectionEntity {
  SectionModel({
    super.id,
    super.name,
    super.isClassTeacher,
  });
  @override
  String toString() {
    return 'SectionModel {"id": $id, "name": $name, "isClassTeacher": $isClassTeacher, }';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'is_class_teacher': isClassTeacher,
    };
  }

  factory SectionModel.fromMap(Map<String, dynamic> map) {
    return SectionModel(
      id: map['id'] != null ? int.parse("${map['id']}") : null,
      name: map['name'],
      isClassTeacher: map['is_class_teacher'],
    );
  }

  static List<SectionModel> fromListMap(List<dynamic> data) {
    return data.map((e) => SectionModel.fromMap(e)).toList();
  }
}
