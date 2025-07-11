import '../../domain/entities/class_entity.dart';
class ClassModel extends ClassEntity{
ClassModel({
    super.id,
    super.name,
    super.shortName,
    super.rank,
    super.isClassTeacher,
  });
  @override
  String toString() {
    return 'ClassModel {"id": $id, "name": $name, "shortName": $shortName, "rank": $rank, "isClassTeacher": $isClassTeacher, }';
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'short_name': shortName,
      'rank': rank,
      'is_class_teacher': isClassTeacher,
    };
  }
  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      id:map['id'] != null ? int.parse("${map['id']}") : null,
      name: map['name'],
      shortName: map['short_name'],
      rank:map['rank'] != null ? int.parse("${map['rank']}") : null,
      isClassTeacher: map['is_class_teacher'],
    );
  }

  static List<ClassModel> fromListMap(List<dynamic>data) {
    return data.map((e) => ClassModel.fromMap(e)).toList();
  }
}

