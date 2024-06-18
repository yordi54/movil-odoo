class  Guardian {
  final int id;
  final String name;
  final String lastname;
  final List<dynamic> studentIds;
  final List<dynamic> userId;

  Guardian({
    required this.id,
    required this.name,
    required this.lastname,
    required this.studentIds,
    required this.userId,
  });

  factory Guardian.fromJson(Map<String, dynamic> json) {
    return Guardian(
      id: json['id'],
      name: json['name'],
      lastname: json['lastname'],
      studentIds: json['student_ids'],
      userId: json['user_id'],
    );
  }

}