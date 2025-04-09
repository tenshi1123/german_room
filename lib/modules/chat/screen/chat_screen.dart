import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:german_room/student_models/chat_models.dart';
import 'package:german_room/student_repo/chat_repo.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.model});
  final ConverastionModel model;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  List<File> photos = <File>[];
  String id = '';
  List<ChatMessageModel> listMessage = <ChatMessageModel>[];
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void openCamera() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CameraCamera(
          onFile: (file) async {
            //Navigator.pop(context);
            await ChatRepo().sendImageMessage(widget.model.id, file);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: const Text('Tin nhắn đã được gửi'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text(
                        'ok',
                        style: TextStyle(fontSize: 20, color: key1Color),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              },
            );
            setState(() {});
          },
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickMultiImage();
    photos = List<File>.from(
      (returnedImage).map(
        (e) => File(e.path),
      ),
    );
    //File(returnedImage!.path);
    if (photos.isNotEmpty) {
      await ChatRepo().sendImageMessage(widget.model.id, photos.last);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Tin nhắn đã được gửi'),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text(
                  'ok',
                  style: TextStyle(fontSize: 20, color: key1Color),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
    }
    setState(() {});
  }

  Future<void> _getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id_user') ?? '';
    setState(() {
      // Cập nhật trạng thái để hiển thị dữ liệu mới
    });
  }

  @override
  void initState() {
    listMessage = widget.model.messages;
    _getIdUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                radius: 21.r,
                backgroundImage: NetworkImage(widget.model.teacherAvatar),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                widget.model.teacherFullName,
                style: defaultText18B.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          toolbarHeight: 60.h,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: mainGradient,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.phone,
                color: Colors.white,
              ),
              onPressed: () {
                _makePhoneCall('19008978');
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            SizedBox(
              height: 700.h,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: widget.model.messages.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 60.h),
                reverse: true,
                //physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: ((listMessage[index].senderType == "1" &&
                              listMessage[index].senderId == id)
                          ? Alignment.topRight
                          : Alignment.topLeft),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ((listMessage[index].senderType == "1" &&
                                  listMessage[index].senderId == id)
                              ? main1Color
                              : state1),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: (listMessage[index].messageType == '0')
                            ? Text(
                                listMessage[index].content,
                                style: defaultText14M.copyWith(
                                  color:
                                      ((listMessage[index].senderType == "1" &&
                                              listMessage[index].senderId == id)
                                          ? Colors.white
                                          : keyBlack),
                                ),
                              )
                            : GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      listMessage[index].content.length == 1
                                          ? 1
                                          : 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                                itemCount: listMessage[index].content.length,
                                itemBuilder: (context, index2) {
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  _FullsizeImage(
                                                url: listMessage[index]
                                                    .content[index2],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Image.network(
                                          listMessage[index].content[index2],
                                          height: listMessage[index]
                                                      .content
                                                      .length ==
                                                  1
                                              ? 250.h
                                              : 125.h,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                margin: EdgeInsets.only(bottom: 16.h),
                //height: 60.h,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          openCamera();
                        },
                        child:
                            SvgPicture.asset('assets/icons/camera_icon.svg')),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                        onTap: () {
                          _pickImageFromGallery();
                        },
                        child:
                            SvgPicture.asset('assets/icons/picture_icon.svg')),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: state2,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                              hintText: "Nhập tin nhắn...",
                              hintStyle: TextStyle(
                                  color: Colors.black.withValues(alpha: 0.95)),
                              border: InputBorder.none),
                          style: defaultText14M,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                        onTap: () async {
                          if (messageController.text.isNotEmpty) {
                            await ChatRepo().sendMessage(
                                widget.model.id, messageController.text);

                            setState(() {
                              listMessage.insert(
                                0,
                                ChatMessageModel(
                                  content: messageController.text,
                                  messageType: "0",
                                  senderType: "1",
                                  createdAt: DateTime.now(),
                                  teacherName: '',
                                  senderId: id,
                                  customerName: '',
                                  userName: '',
                                ),
                              );
                            });
                            messageController.clear();
                            if (!context.mounted) return;
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: const Text('Tin nhắn đã được gửi'),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      isDefaultAction: true,
                                      child: Text(
                                        'ok',
                                        style: TextStyle(
                                            fontSize: 20, color: key1Color),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(
                                          (_) => false,
                                        );
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        },
                        // onTap: () async {
                        //   messageController.clear();

                        //   showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return CupertinoAlertDialog(
                        //         title: const Text('Tin nhắn đã được gửi'),
                        //         actions: <Widget>[
                        //           CupertinoDialogAction(
                        //             isDefaultAction: true,
                        //             child: Text(
                        //               'ok',
                        //               style: TextStyle(
                        //                   fontSize: 20, color: key1Color),
                        //             ),
                        //             onPressed: () {
                        //               Navigator.of(context, rootNavigator: true)
                        //                   .pop(
                        //                 (_) => false,
                        //               );
                        //             },
                        //           )
                        //         ],
                        //       );
                        //     },
                        //   );
                        // },
                        child:
                            SvgPicture.asset('assets/icons/plane_outline.svg')),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class _FullsizeImage extends StatelessWidget {
  const _FullsizeImage({
    required this.url,
  });
  final String url;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: InteractiveViewer(
            panEnabled: true,
            boundaryMargin: const EdgeInsets.all(200),
            minScale: 0.5,
            maxScale: 4,
            child: Image.network(
              url,
              fit: BoxFit.fitWidth,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
