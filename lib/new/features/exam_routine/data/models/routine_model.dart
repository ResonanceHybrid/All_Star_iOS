import '../../domain/entities/routine_entity.dart';

class RoutineModel extends RoutineEntity {
  RoutineModel({
    super.id,
    super.className,
    super.subject,
    super.date,
    super.createdAt,
  });
  @override
  String toString() {
    return 'RoutineModel {"id": $id, "class": $className, "subject": $subject, "date": $date, "createdAt": $createdAt, }';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'class': className,
      'subject': subject,
      'date': date,
      'created_at': createdAt,
    };
  }

  factory RoutineModel.fromMap(Map<String, dynamic> map) {
    return RoutineModel(
      id: map['id'] != null ? int.parse("${map['id']}") : null,
      className: map['class'],
      subject: map['subject'],
      date: map['date'],
      createdAt: map['created_at'],
    );
  }
}
