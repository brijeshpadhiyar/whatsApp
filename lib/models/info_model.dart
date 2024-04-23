import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class InfoModel {
  String name;
  String message;
  String time;
  String profilePic;
  InfoModel({
    required this.name,
    required this.message,
    required this.time,
    required this.profilePic,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'message': message,
      'time': time,
      'profilePic': profilePic,
    };
  }

  factory InfoModel.fromMap(Map<String, dynamic> map) {
    return InfoModel(
      name: map['name'] as String,
      message: map['message'] as String,
      time: map['time'] as String,
      profilePic: map['profilePic'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory InfoModel.fromJson(String source) => InfoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
