// import 'package:cloud_firestore/cloud_firestore.dart';

// class LiveStream {
//   final String title;
//   final String image;
//   final String uid;
//   final String username;
//   final startedAt;
//   final int viewers;
//   final String channelId;

//   LiveStream(
//       {required this.title,
//       required this.image,
//       required this.uid,
//       required this.username,
//       required this.startedAt,
//       required this.viewers,
//       required this.channelId});

//   Map<String, dynamic> toJson() {
//     return{
//         'title': title,
//         'image': image,
//         'uid': uid,
//         'username': username,
//         'startedAt': startedAt,
//         'viewers': viewers,
//         'channelId': channelId,
//     };
//       }
//   static LiveStream fromJson(DocumentSnapshot snapshot) {
//     final snap = snapshot.data() as Map<String, dynamic>;
//     return LiveStream(
//       title: snap['title'] ?? '',
//       image: snap['image'] ?? '',
//       uid: snap['uid'] ?? '',
//       username: snap['username'] ?? '',
//       startedAt: snap['startedAt'] ?? '',
//       viewers: snap['viewers'].toInt() ?? 0,
//       channelId: snap['channelId'] ?? '',
//     );
//   }
// }
import 'dart:convert';

class LiveStream {
  final String title;
  final String image;
  final String uid;
  final String username;
  final startedAt;
  final int viewers;
  final String channelId;

  LiveStream({
    required this.title,
    required this.image,
    required this.uid,
    required this.username,
    required this.viewers,
    required this.channelId,
    required this.startedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'uid': uid,
      'username': username,
      'viewers': viewers,
      'channelId': channelId,
      'startedAt': startedAt,
    };
  }

  factory LiveStream.fromMap(Map<String, dynamic> map) {
    return LiveStream(
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      viewers: map['viewers']?.toInt() ?? 0,
      channelId: map['channelId'] ?? '',
      startedAt: map['startedAt'] ?? '',
    );
  }
}
