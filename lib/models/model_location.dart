class LocationModel {
  final int id;
  final String name;
  final double lat;
  final double long;

  LocationModel(
    this.id,
    this.name,
    this.lat,
    this.long,
  );

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return LocationModel(
      json['id'] ?? 0,
      json['name'] ?? "Unknown",
      json['lat'] ?? 0.0,
      json['long'] ?? 0.0,
    );
  }
}
