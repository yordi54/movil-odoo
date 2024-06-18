class Period {

  final int id;
  final String name;
  final List<dynamic> managementId;


  Period({
    required this.id,
    required this.name,
    required this.managementId,
  });

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      id: json['id'],
      name: json['name'],
      managementId: json['management_id'],
    );
  }
}