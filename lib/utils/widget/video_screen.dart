import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vdocipher_flutter/vdocipher_flutter.dart';

class VdoCipherScreen extends StatefulWidget {
  const VdoCipherScreen({super.key});

  @override
  VdoCipherScreenState createState() => VdoCipherScreenState();
}

class VdoCipherScreenState extends State<VdoCipherScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Video khóa học'),
          centerTitle: true,
        ),
        body: const VdoPlaybackView(
          controls: true,
        ));
  }
}

const EmbedInfo sample_1 = EmbedInfo.streaming(
    otp: '20150519versASE31ba8fc50a0ac49b8e74b9c40f49e099755cd36dc8adccaa3',
    playbackInfo:
        'eyJ2aWRlb0lkIjoiM2YyOWI1NDM0YTVjNjE1Y2RhMThiMTZhNjIzMmZkNzUifQ==');

class VdoPlaybackView extends StatefulWidget {
  final bool controls;

  const VdoPlaybackView({super.key, this.controls = true});

  @override
  VdoPlaybackViewState createState() => VdoPlaybackViewState();
}

class VdoPlaybackViewState extends State<VdoPlaybackView> {
  VdoPlayerController? _controller;
  VdoPlayerValue? vdoPlayerValue;
  final double aspectRatio = 16 / 9;
  final ValueNotifier<bool> _isFullScreen = ValueNotifier(false);
  Duration? duration;

  @override
  Widget build(BuildContext context) {
    String? mediaId = ModalRoute.of(context)?.settings.arguments as String?;
    EmbedInfo embedInfo = sample_1;
    if (mediaId != null && mediaId.isNotEmpty) {
      embedInfo = EmbedInfo.offline(mediaId: mediaId);
    }
    return Scaffold(
        body: SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: _getPlayerWidth(),
              height: _getPlayerHeight(),
              child: VdoPlayer(
                embedInfo: embedInfo,
                aspectRatio: aspectRatio,
                onError: _onVdoError,
                onFullscreenChange: _onFullscreenChange,
                onPlayerCreated: _onPlayerCreated,
                controls: widget.controls,
                onPictureInPictureModeChanged: _onPictureInPictureModeChanged,
              ),
            )
          ],
        ),
      ]),
    ));
  }

  _onVdoError(VdoError vdoError) {
    if (kDebugMode) {
      print("Oops, the system encountered a problem: ${vdoError.message}");
    }
  }

  _onPlayerCreated(VdoPlayerController? controller) {
    setState(() {
      _controller = controller;
      _onEventChange(_controller);
    });
  }

  _onPictureInPictureModeChanged(bool isInPictureInPictureMode) {}

  _onEventChange(VdoPlayerController? controller) {
    controller?.addListener(() {
      setState(() {
        vdoPlayerValue = controller.value;
      });
    });
  }

  _onFullscreenChange(isFullscreen) {
    setState(() {
      _isFullScreen.value = isFullscreen;
    });
  }

  _getPlayerWidth() {
    return kIsWeb ? 800 : MediaQuery.of(context).size.width;
  }

  _getPlayerHeight() {
    return kIsWeb
        ? 550
        : _isFullScreen.value
            ? MediaQuery.of(context).size.height
            : _getHeightForWidth(MediaQuery.of(context).size.width);
  }

  double _getHeightForWidth(double width) {
    return width / aspectRatio;
  }
}
