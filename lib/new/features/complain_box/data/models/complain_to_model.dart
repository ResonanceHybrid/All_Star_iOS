import '../../domain/entities/complain_to_entity.dart';

class ComplainToModel extends ComplainToEntity {
  ComplainToModel({
    super.id,
    super.name,
  });
  @override
  String toString() {
    return 'ComplainToModel {"id": $id, "name": $name, }';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory ComplainToModel.fromMap(Map<String, dynamic> map) {
    return ComplainToModel(
      id: map['id'] != null ? int.parse("${map['id']}") : null,
      name: map['name'],
    );
  }

  static fromListMap(List<dynamic> data) {
    List<ComplainToModel> complainTo = [];
    for (var item in data) {
      complainTo.add(ComplainToModel.fromMap(item));
    }
      return complainTo;
  }
}
