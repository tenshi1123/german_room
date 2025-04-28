import 'package:flutter/material.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoWebviewPage extends StatefulWidget {
  const VideoWebviewPage({super.key, required this.link});
  final String link;
  @override
  State<VideoWebviewPage> createState() => _VideoWebviewPageState();
}

class _VideoWebviewPageState extends State<VideoWebviewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
        widget.link,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Xem Video',
        style: defaultText14M,
      )),
      body: WebViewWidget(controller: _controller),
    );
  }
}
