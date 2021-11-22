import 'dart:io';

import 'package:listar_flutter/models/model.dart';

enum Status { sent, received }
enum Type { textMessage, photo }

class MessageModel {
  final int id;
  final String roomName;
  final List<UserModel> member;
  final UserModel from;
  final String message;
  final DateTime date;
  final Status status;
  final File file;
  final Type type;

  MessageModel(
    this.id,
    this.roomName,
    this.member,
    this.from,
    this.message,
    this.date,
    this.status,
    this.file,
    this.type,
  );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    Status status = Status.sent;
    File file;
    Type type = Type.textMessage;
    UserModel from;

    if (json['status'] == 'received') {
      status = Status.received;
    }

    if (json['file'] != null) {
      file = File(json['file']);
      type = Type.photo;
    }

    if (json['from'] != null) {
      from = UserModel.fromJson(json['from']);
    }

    final member = (json['member'] as List ?? []).map((item) {
      return UserModel.fromJson(item);
    }).toList();

    return MessageModel(
      json['id'] ?? 0,
      json['room_name'] ?? '',
      member,
      from,
      json['message'] ?? 'Unknown',
      DateTime.tryParse(json['date']) ?? DateTime.now(),
      status,
      file,
      type,
    );
  }
}
