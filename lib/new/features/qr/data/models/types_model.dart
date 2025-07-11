import '../../domain/entities/types_entity.dart';
class TypesModel extends TypesEntity{
TypesModel({
    super.attendance,
  });
  @override
  String toString() {
    return 'TypesModel {"attendance": $attendance, }';
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      'attendance': attendance,
    };
  }
  factory TypesModel.fromMap(Map<String, dynamic> map) {
    return TypesModel(
      attendance: map['attendance'],
    );
  }
}

