class Employee {
  final int id;
  final String name;
  final List<dynamic> scheduleIds;
  final List<dynamic> departmentId;
  final List<dynamic> jobId;
  final List<dynamic> userId;
  final String? workEmail;

  Employee({
    required this.id,
    required this.name,
    required this.scheduleIds,
    required this.departmentId,
    required this.jobId,
    required this.userId,
    this.workEmail,
  });

  
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      scheduleIds: json['schedule_ids'],
      departmentId: json['department_id'],
      jobId: json['job_id'],
      userId: json['user_id'],
      workEmail: json['work_email'],
    );
  }


}