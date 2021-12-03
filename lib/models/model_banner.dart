class ImageModel {
  final String id;
  final String image;

  ImageModel(
    this.id,
    this.image,
  );

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ImageModel(
      json['_id'] ?? "0",
      json['image'] ?? "Unknown",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
    };
  }
}
