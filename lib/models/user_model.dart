import 'dart:convert';

class UserModel {
  final String name;
  final String uid;
  final String profilePic;
  final bool isOnline;
  final String number;
  final List<dynamic> gropId;

  UserModel({required this.name, required this.uid, required this.profilePic, required this.isOnline, required this.number, required this.gropId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'isOnline': isOnline,
      'number': number,
      'gropId': gropId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      uid: map['uid'] as String,
      profilePic: map['profilePic'] as String,
      isOnline: map['isOnline'] as bool,
      number: map['number'] as String,
      gropId: List<dynamic>.from((map['gropId'] as List<dynamic>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
