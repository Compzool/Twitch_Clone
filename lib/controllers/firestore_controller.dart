// import 'dart:typed_data';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';
// import 'package:twitch_clone/controllers/storage_controller.dart';
// import 'package:twitch_clone/models/livestream.dart';
// import 'package:twitch_clone/providers/user_provider.dart';
// import 'package:twitch_clone/utils/constants.dart';
// import 'package:twitch_clone/utils/utils.dart';
// import 'package:uuid/uuid.dart';

// class FirestoreController {
//   final StorageController _storageController = StorageController();
//   Future<String> startLiveStream(
//       BuildContext context, String title, Uint8List? image) async {
//     final user = Provider.of<UserProvider>(context, listen: false);
//     String channelId = '';
//     try {
//       if (title.isNotEmpty && image != null) {
//         if (!((await firestore
//                 .collection("livestream")
//                 .doc('${user.user.uid}${user.user.username}')
//                 .get())
//             .exists)) {
//           String thumbnailUrl = await _storageController.uploadImageToStorage(
//               "Live-Stream-Thumbnails", image, user.user.uid);

//           channelId = '${user.user.uid}${user.user.username}';
//           LiveStream liveStream = LiveStream(
//               title: title,
//               image: thumbnailUrl,
//               uid: user.user.uid,
//               username: user.user.username,
//               startedAt: DateTime.now(),
//               viewers: 0,
//               channelId: channelId);

//           firestore
//               .collection("livestream")
//               .doc(channelId)
//               .set(liveStream.toJson());
//         } else {
//           showSnackBar(context, "Live Stream already ON!");
//         }
//       } else {
//         showSnackBar(context, "Please fill all the fields");
//       }
//     } on FirebaseException catch (e) {
//       showSnackBar(context, e.toString());
//     }
//     return channelId;
//   }

//   Future<void> endLiveStream(String channelId) async {
//     try {
//       QuerySnapshot snap = await firestore
//           .collection("livestream")
//           .doc(channelId)
//           .collection('comments')
//           .get();

//       for (int i = 0; i < snap.docs.length; i++) {
//         await firestore
//             .collection("livestream")
//             .doc(channelId)
//             .collection('comments')
//             .doc((snap.docs[i].data()! as dynamic)['commentId'])
//             .delete();
//       }
//       await firestore.collection("livestream").doc(channelId).delete();
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   Future<void> updateViewCount(String id, bool isIncrease) async {
//     try {
//       await firestore.collection("livestream").doc(id).update({
//         if (isIncrease)
//           'viewers': FieldValue.increment(1)
//         else
//           'viewers': FieldValue.increment(-1)
//       });
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   Future<void> chat(String text, String id, BuildContext context) async {
//     final user = Provider.of<UserProvider>(context, listen: false);
//     try {
//       // await firestore
//       //     .collection("livestream")
//       //     .doc(id)
//       //     .collection('comments')
//       //     .add({
//       //   'comment': text,
//       //  'commentId': DateTime.now().millisecondsSinceEpoch.toString(),
//       //   'username':
//       //       user.user.username,
//       //   'uid': user.user.uid,
//       //   'timestamp': DateTime.now().millisecondsSinceEpoch
//       // });
//       String commentId = Uuid().v1();
//       await firestore.collection("livestream").doc(id).collection('comments').doc(commentId).set({
//         'message': text,
//         'commentId': commentId,
//         'username': user.user.username,
//         'uid': user.user.uid,
//         'createdAt': DateTime.now()
//       });
//     } on FirebaseException catch (e) {
//       showSnackBar(context, e.message!);
//     }
//   }
// }
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:twitch_clone/controllers/storage_controller.dart';
import 'package:twitch_clone/models/livestream.dart';
import 'package:twitch_clone/providers/user_provider.dart';
import 'package:twitch_clone/utils/constants.dart';
import 'package:twitch_clone/utils/utils.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();

  Future<String> startLiveStream(
      BuildContext context, String title, Uint8List? image) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    String channelId = '';
    try {
      if (title.isNotEmpty && image != null) {
        if (!((await _firestore
                .collection('livestream')
                .doc('${user.user.uid}${user.user.username}')
                .get())
            .exists)) {
          String thumbnailUrl = await _storageMethods.uploadImageToStorage(
            'livestream-thumbnails',
            image,
            user.user.uid,
          );
          channelId = '${user.user.uid}${user.user.username}';

          LiveStream liveStream = LiveStream(
            title: title,
            image: thumbnailUrl,
            uid: user.user.uid,
            username: user.user.username,
            viewers: 0,
            channelId: channelId,
            startedAt: DateTime.now(),
          );

          _firestore
              .collection('livestream')
              .doc(channelId)
              .set(liveStream.toMap());
        } else {
          showSnackBar(
              context, 'Two Livestreams cannot start at the same time.');
        }
      } else {
        showSnackBar(context, 'Please enter all the fields');
      }
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
    return channelId;
  }

  Future<void> chat(String text, String id, BuildContext context) async {
    final user = Provider.of<UserProvider>(context, listen: false);

    try {
      String commentId = const Uuid().v1();
      await _firestore
          .collection('livestream')
          .doc(id)
          .collection('comments')
          .doc(commentId)
          .set({
        'username': user.user.username,
        'message': text,
        'uid': user.user.uid,
        'createdAt': DateTime.now(),
        'commentId': commentId,
      });
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> updateViewCount(String id, bool isIncrease) async {
    try {
      await _firestore.collection('livestream').doc(id).update({
        'viewers': FieldValue.increment(isIncrease ? 1 : -1),
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> endLiveStream(String channelId) async {
    try {
      QuerySnapshot snap = await _firestore
          .collection('livestream')
          .doc(channelId)
          .collection('comments')
          .get();

      for (int i = 0; i < snap.docs.length; i++) {
        await _firestore
            .collection('livestream')
            .doc(channelId)
            .collection('comments')
            .doc(
              ((snap.docs[i].data()! as dynamic)['commentId']),
            )
            .delete();
      }
      await _firestore.collection('livestream').doc(channelId).delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
