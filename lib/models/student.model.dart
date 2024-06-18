class Student {
  final int id;
  final String name;
  final String lastname;

  Student({
    required this.id,
    required this.name,
    required this.lastname,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      lastname: json['lastname'],
    );
  }
}