class UserModel {
  final String id;
  final String name;
  final String firstName;
  final String lastName;
  final String email;
  final String nickname;
  final String image;
  final String link;
  final String level;
  final String description;
  final String tag;
  final double rate;
  final String token;
  final String website;

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
    this.email,
    this.website,
    this.firstName,
    this.lastName,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return UserModel(
      json['id'] ?? '0',
      json['full_name'] ?? 'Unknown',
      json['nickname'] ?? 'Unknown',
      json['photo'] ?? 'Unknown',
      json['url'] ?? 'Unknown',
      json['level'] ?? 'Unknown',
      json['street'] ?? 'Unknown',
      json['tag'] ?? 'Unknown',
      json['rate'] ?? 0.0,
      json['token'] ?? 'Unknown',
      json['email'] ?? "Unknown",
      json['url'] ?? "Unknown",
      json['firstname'] ?? "Unknown",
      json['lastname'] ?? "Unknown",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': name,
      'firstName': firstName,
      'lastName': lastName,
      'nickname': nickname,
      'photo': image,
      'url': link,
      'level': level,
      'description': description,
      'tag': tag,
      'rate': rate,
      'website': website,
      'token': token,
    };
  }
}
