class Announcement {
  final int id;
  final String reason;
  final String description;

  Announcement({
    required this.id,
    required this.reason,
    required this.description,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      reason: json['reason'],
      description: json['description'],
    );
  }
}