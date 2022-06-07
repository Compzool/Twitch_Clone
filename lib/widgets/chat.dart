import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_clone/controllers/firestore_controller.dart';
import 'package:twitch_clone/providers/user_provider.dart';
import 'package:twitch_clone/utils/constants.dart';
import 'package:twitch_clone/utils/hexcolor.dart';
import 'package:twitch_clone/widgets/custom_textfield.dart';
import 'package:twitch_clone/widgets/loading_indicator.dart';

class Chat extends StatefulWidget {
  final String channelId;
  Chat({Key? key, required this.channelId}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _chatController = TextEditingController();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width > 600 ? size.width * 0.25: double.infinity,
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder<dynamic>(
              stream: firestore
                  .collection("livestream")
                  .doc(widget.channelId)
                  .collection('comments')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingIndicator();
                }
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        title: Text(
                          snapshot.data.docs[index]['username'],
                          style: TextStyle(
                            color: snapshot.data.docs[index]['uid'] ==
                                    userProvider.user.uid
                                ? Colors.cyan
                                : HexColor('651FFF'),
                          ),
                        ),
                        subtitle: Text(snapshot.data.docs[index]['message']),
                      );
                    }));
              }),
            )),
            CustomTextField(
                controller: _chatController,
                text: '',
                icon: Icons.message_rounded,
                onTap: (val) {
                  FirestoreMethods()
                      .chat(_chatController.text, widget.channelId, context);
                  setState(() {
                    _chatController.clear();
                  });
                })
          ],
        ));
  }
}
