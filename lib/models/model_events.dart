class EventsModel {
  final String id;
  final String title;
  final String day_num;
  final String day;
  final String month;
  final String image;
  final String video;
  final String owner_Id;
  final List joined_users;
  EventsModel(
    this.id,
    this.title,
    this.day_num,
    this.day,
    this.month,
    this.image,
    this.video,
    this.owner_Id,
    this.joined_users,
  );

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return EventsModel(
      json['_id'] ?? "0",
      json['title'] ?? "Unknown",
      json['day_num'] ?? "Unknown",
      json['day'] ?? "Unknown",
      json['month'] ?? "Unknown",
      json['image'] ?? "Unknown",
      json['video'] ?? "Unknown",
      json['owner_Id'] ?? "Unknown",
      json['joined_users'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "day_num": day_num,
      "day": day,
      "month": month,
      "owner_Id": owner_Id,
      "joined_user": joined_users,
    };
  }
}

class EventMonths {
  String name;
  bool selected;
  EventMonths(this.name, this.selected);

  factory EventMonths.fromJson(String monthName, selected) {
    if (monthName == null) return null;
    return EventMonths(
      monthName ?? "Unknown",
      selected ?? false,
    );
  }
}
