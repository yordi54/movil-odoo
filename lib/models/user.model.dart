class User {
  final int? id;
  final List<dynamic> employeeIds;
  final List<dynamic> companyIds;
  final String completeName;
  final String image1920;
  final String? password;


  User({
    this.id,
    required this.employeeIds,
    required this.companyIds,
    required this.completeName,
    required this.image1920,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      employeeIds: json['employee_ids'],
      companyIds: json['company_ids'],
      completeName: json['complete_name'],
      image1920: json['image_1920'],
    );
  }
  


}