class UserModel {
  final int id;
  final String name;
  final String nickname;
  final String image;
  final String link;
  final String level;
  final String description;
  final String tag;
  final double rate;
  final String token;

  UserModel(
    this.id,
    this.name,
    this.nickname,
    this.image,
    this.link,
    this.level,
    this.description,
    this.tag,
    this.rate,
    this.token,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return UserModel(
      json['id'] ?? 0,
      json['full_name'] ?? 'Unknown',
      json['nickname'] ?? 'Unknown',
      json['photo'] ?? 'Unknown',
      json['url'] ?? 'Unknown',
      json['level'] ?? 'Unknown',
      json['description'] ?? 'Unknown',
      json['tag'] ?? 'Unknown',
      json['rate'] ?? 0.0,
      json['token'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': name,
      'nickname': nickname,
      'photo': image,
      'url': link,
      'level': level,
      'description': description,
      'tag': tag,
      'rate': rate,
      'token': token,
    };
  }
}
