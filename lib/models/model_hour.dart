class HourModel {
  final String title;
  final String time;

  HourModel(
    this.title,
    this.time,
  );

  factory HourModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return HourModel(
      json['title'] ?? "Unknown",
      json['time'] ?? "Unknown",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "time": time,
    };
  }
}
