import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/modules/bottombar/screen/extension.dart/hoc_lieu/list_hoc_lieu_screen.dart';
import 'package:german_room/student_models/hoclieu_model.dart';
import 'package:german_room/student_repo/hoc_lieu_repo.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:just_audio/just_audio.dart';

class DetailLearingScreen extends StatefulWidget {
  const DetailLearingScreen({
    super.key,
    required this.detailearningModel,
    required this.url,
  });
  final DetailLearingModel detailearningModel;
  final String url;

  @override
  State<DetailLearingScreen> createState() => _DetailLearingScreenState();
}

class _DetailLearingScreenState extends State<DetailLearingScreen> {
  late DetailLearingModel detailLearingModel;
  int? expandedIndex;
  @override
  void initState() {
    super.initState();
    detailLearingModel = widget.detailearningModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 130.h,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 390.w,
                      height: 120.h,
                      decoration: BoxDecoration(gradient: mainGradient),
                    ),
                  ),
                  Positioned(
                    bottom: 20.h,
                    left: 22.w,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Chi tiết Bài học',
                          style: defaultText20B.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0.h,
                    left: 250.w,
                    child: Image.asset(
                      'assets/images/course_icon.png',
                      width: 115.w,
                      height: 92.h,
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
            ),
            Text(
              detailLearingModel.detailModel.name,
              style: defaultText20B.copyWith(
                color: key1Color,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Html(
                data: detailLearingModel.detailModel.detail,
                style: {
                  "body": Style(
                    fontSize: FontSize(14.sp),
                    color: key1Color,
                    textAlign: TextAlign.justify,
                  ),
                },
              ),
            ),
            // List of videos
            SizedBox(
              height: 20.h,
            ),

            SizedBox(
              height: detailLearingModel.listVideo.isEmpty ? 10.h : 0,
            ),
            detailLearingModel.listVideo.isEmpty
                ? Text(
                    'Không có video nào',
                    style: defaultText16B.copyWith(color: key2Color),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true, // ✅ cần thiết khi đặt trong scroll view
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: detailLearingModel.listVideo.length,
                    itemBuilder: (context, index) {
                      final video = detailLearingModel.listVideo[index];
                      return video.type == 'audio'
                          ? SimpleAudioPlayer(
                              model: video,
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                // Ảnh mờ
                                Opacity(
                                  opacity: 0.6, // điều chỉnh độ mờ
                                  child: Image.network(
                                    widget.url,
                                    height: 200.h,
                                    width: 350.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: Colors.black45,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              ],
                            );
                    },
                  ),
            // List of questions
            // SizedBox(
            //   height: 16.h,
            // ),
            Text(
              'Danh sách câu hỏi',
              style: defaultText20B.copyWith(
                color: key1Color,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: detailLearingModel.listQuestion.length,
              itemBuilder: (context, index) {
                final question = detailLearingModel.listQuestion[index];
                final isExpanded = expandedIndex == index;

                return Container(
                  margin:
                      EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
                  decoration: BoxDecoration(
                    color: isExpanded ? const Color(0xfff3faff) : Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      key: Key(index.toString()), // để giữ trạng thái mở
                      tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
                      onExpansionChanged: (expanded) {
                        setState(() {
                          expandedIndex = expanded ? index : null;
                        });
                      },
                      title:
                          Text('Übungen ${index + 1}', style: defaultText16B),
                      trailing: Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 20.sp,
                        color: Colors.black,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                question.title,
                                style: defaultText14M.copyWith(
                                    color: Colors.grey[800]),
                              ),
                              SizedBox(height: 12.h),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    String url =
                                        await HocLieuRepo().getLinkQuestion(
                                      partId: question.partLearningMaterialsId,
                                      questionId: question
                                          .questionsPartLearningMaterialId,
                                    );
                                    if (!await launchUrl(Uri.parse(url))) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF00BFA6),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 10.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  child: Text('Làm bài',
                                      style: defaultText14B.copyWith(
                                          color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class SimpleAudioPlayer extends StatefulWidget {
  final VideoModel model;

  const SimpleAudioPlayer({super.key, required this.model});

  @override
  State<SimpleAudioPlayer> createState() => _SimpleAudioPlayerState();
}

class _SimpleAudioPlayerState extends State<SimpleAudioPlayer> {
  late AudioPlayer _player;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _init();
    _player.durationStream.listen((d) {
      if (d != null) {
        setState(() => _duration = d);
      }
    });
    _player.positionStream.listen((p) {
      setState(() => _position = p);
    });
  }

  Future<void> _init() async {
    await _player.setUrl(widget.model.link);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            children: [
              // Nút play/pause
              IconButton(
                icon: Icon(
                  _player.playing
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_fill,
                  size: 36,
                ),
                onPressed: () {
                  _player.playing ? _player.pause() : _player.play();
                },
              ),

              // Thời gian
              Text(
                '${formatDuration(_position)} / ${formatDuration(_duration)}',
                style: defaultText14M,
              ),

              const SizedBox(width: 10),

              // Thanh tiến trình
              Expanded(
                child: Slider(
                  value: _position.inSeconds
                      .toDouble()
                      .clamp(0, _duration.inSeconds.toDouble()),
                  min: 0,
                  max: _duration.inSeconds.toDouble(),
                  onChanged: (value) {
                    _player.seek(Duration(seconds: value.toInt()));
                  },
                ),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: '${widget.model.type} - ',
            style: defaultText16M,
            children: [
              TextSpan(
                  text: widget.model.name,
                  style: defaultText16B.copyWith(color: main1Color)),
            ],
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
