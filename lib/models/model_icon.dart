class IconModel {
  final String title;
  final String icon;

  IconModel(
    this.title,
    this.icon,
  );

  factory IconModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return IconModel(
      json['title'] ?? "Unknown",
      json['icon'] ?? "Unknown",
    );
  }
}
