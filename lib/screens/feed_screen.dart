import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twitch_clone/controllers/firestore_controller.dart';
import 'package:twitch_clone/models/livestream.dart';
import 'package:twitch_clone/screens/broadcast_screen.dart';
import 'package:twitch_clone/utils/constants.dart';
import 'package:twitch_clone/widgets/loading_indicator.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:twitch_clone/widgets/responsive_widget/responsive_layout.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
      child: Column(
        children: [
          Text(
            "Live Users",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          StreamBuilder<dynamic>(
            stream: firestore.collection("livestream").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingIndicator();
              }
              return Expanded(
                child: ResponsiveLayout(
                  desktopBody: GridView.builder(
                      itemCount: snapshot.data.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 16 / 9),
                      itemBuilder: (context, index) {
                        LiveStream post =
                            LiveStream.fromMap(snapshot.data.docs[index].data());
                        return InkWell(
                            onTap: () async {
                              await FirestoreMethods()
                                  .updateViewCount(post.channelId, true);

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => BroadcastScreen(
                                        isBroadcaster: false,
                                        channelId: post.channelId,
                                      ))));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.35,
                                    child: Image.network(
                                      post.image,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.username,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        post.title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("${post.viewers} watching"),
                                      Text(
                                        "Started: ${timeago.format(post.startedAt.toDate())}",
                                        
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      }),
                  mobileBody: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: ((context, index) {
                        var post =
                            LiveStream.fromMap(snapshot.data.docs[index].data());
                        return InkWell(
                            onTap: () async {
                              await FirestoreMethods()
                                  .updateViewCount(post.channelId, true);

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => BroadcastScreen(
                                        isBroadcaster: false,
                                        channelId: post.channelId,
                                      ))));
                            },
                            child: Container(
                              height: size.height * 0.11,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Image.network(post.image),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.username,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        post.title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("${post.viewers} watching"),
                                      Text(
                                        "Started: ${timeago.format(post.startedAt.toDate())}",
                                        
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.more_vert)),
                                ],
                              ),
                            ));
                      })),
                ),
              );
            }),
          
        ],
      ),
    ));
  }
}
