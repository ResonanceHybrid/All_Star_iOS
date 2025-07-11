
    import 'dart:convert';
    
    class TypesEntity {
  final String? attendance;
TypesEntity({
    this.attendance,
  });
  TypesEntity copyWith({
    String? attendance,
  }) {
    return TypesEntity(
      attendance: attendance ?? this.attendance,
    );
  }
  @override
  String toString() {
    return 'TypesEntity {"attendance": $attendance, }';
  }
  Map<String, dynamic> toMap() {
    return {
      'attendance': attendance,
    };
  }
  factory TypesEntity.fromMap(Map<String, dynamic> map) {
    return TypesEntity(
      attendance: map['attendance'],
    );
  }
  

String toJson() => json.encode(toMap());

  factory TypesEntity.fromJson(String source) =>
    TypesEntity.fromMap(json.decode(source) as Map<String, dynamic>);


  @override
  bool operator ==(covariant TypesEntity other) {
    if (identical(this, other)) return true;
    return   attendance == other.attendance;
  }
  @override
  int get hashCode {
    return attendance.hashCode;
  }
}

