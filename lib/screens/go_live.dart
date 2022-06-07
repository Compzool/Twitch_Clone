import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:twitch_clone/controllers/firestore_controller.dart';
import 'package:twitch_clone/screens/broadcast_screen.dart';
import 'package:twitch_clone/utils/colors.dart';
import 'package:twitch_clone/utils/constants.dart';
import 'package:twitch_clone/utils/utils.dart';
import 'package:twitch_clone/widgets/custom_button.dart';
import 'package:twitch_clone/widgets/custom_textfield.dart';
import 'package:twitch_clone/widgets/responsive_widget/responsive_widget.dart';

class GoLiveScreen extends StatefulWidget {
  GoLiveScreen({Key? key}) : super(key: key);

  @override
  State<GoLiveScreen> createState() => _GoLiveScreen();
}

class _GoLiveScreen extends State<GoLiveScreen> {
  TextEditingController _thumbnailController = TextEditingController();
  Uint8List? image;
  @override
  void dispose() {
    _thumbnailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      return ResponsiveWidget(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Uint8List? pickedImage = await pickImage();
                            if (pickedImage != null) {
                              setState(() {
                                image = pickedImage;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 20),
                            child: image != null
                                ? SizedBox(
                                    height: 300,
                                    child: Image.memory(image!),
                                  )
                                : DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(10),
                                    dashPattern: const [10, 4],
                                    strokeCap: StrokeCap.round,
                                    color: buttonColor,
                                    child: Container(
                                      width: double.infinity,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: buttonColor.withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.folder_open,
                                            size: 40,
                                            color: buttonColor,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'Select Your Thumbnail ',
                                            style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Title",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            CustomTextField(
                                controller: _thumbnailController,
                                text: "",
                                icon: Icons.photo_size_select_actual_rounded),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: CustomButton(
                          text: "Go Live!", pressed: () => goLiveStream(context)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }));
  }

  void goLiveStream(BuildContext context) async {
    String channelId = await FirestoreMethods()
        .startLiveStream(context, _thumbnailController.text.trim(), image);
    if (channelId.isNotEmpty) {
      showSnackBar(context, "Live Stream Started Successfully");
      // Navigator.pushNamed(context, '/broadcast',arguments: channelId);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: ((context) => BroadcastScreen(
            isBroadcaster: true,
            channelId: channelId,
          ))));
    }
  }
}
