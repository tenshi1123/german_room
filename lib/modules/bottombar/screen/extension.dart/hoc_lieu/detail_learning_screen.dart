import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/modules/bottombar/screen/extension.dart/hoc_lieu/list_hoc_lieu_screen.dart';
import 'package:german_room/student_models/hoclieu_model.dart';
import 'package:german_room/student_repo/hoc_lieu_repo.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailLearingScreen extends StatefulWidget {
  const DetailLearingScreen({
    super.key,
    required this.detailearningModel,
  });
  final DetailLearingModel detailearningModel;

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
                horizontal: 20.w,
              ),
              child: Html(
                data: testHtml,
                style: {
                  "body": Style(
                    fontSize: FontSize(16.sp),
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
            Text(
              'Danh sách Video',
              style: defaultText20B.copyWith(
                color: key1Color,
              ),
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
                      return ListTile(
                        title: Text(video.name, style: defaultText16B),
                        leading: Icon(Icons.play_circle,
                            size: 40.sp, color: Colors.grey),
                        onTap: () async {
                          if (!await launchUrl(Uri.parse(video.link))) {
                            throw Exception('Could not launch ');
                          }
                        },
                      );
                    },
                  ),
            // List of questions
            SizedBox(
              height: 16.h,
            ),
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

class _CourseItem extends StatelessWidget {
  const _CourseItem({required this.index, required this.model});
  final int index;
  final KhoaHocModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.w),
      //height: 402.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              model.courseImg,
              width: 350.w,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            width: 330.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' Khóa học : ${model.name}',
                  style: TextStyle(
                    color: key1Color,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () async {
              List<HocLieuModel> listHoclieuModel =
                  await HocLieuRepo().getDsCap3(courseId: model.courseId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopicListScreen(
                    topics: listHoclieuModel,
                  ),
                ),
              );
            },
            child: Container(
              height: 39.h,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: key2Color,
                  )),
              child: Center(
                child: Text(
                  'Chi tiết',
                  style: TextStyle(
                    color: key1Color,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: key2Color,
            thickness: 1.h,
          )
        ],
      ),
    );
  }
}

String testHtml =
    '<style>\r\n    body {\r\n      font-family: sans-serif;\r\n      padding: 10px;\r\n      margin: 0;\r\n      line-height: 1.6;\r\n    }\r\n\r\n    img {\r\n      max-width: 100%;\r\n      height: auto;\r\n      display: block;\r\n      margin-bottom: 1em;\r\n    }\r\n\r\n    table {\r\n      width: 100%;\r\n      border-collapse: collapse;\r\n    }\r\n\r\n    td, th {\r\n      padding: 10px;\r\n      vertical-align: top;\r\n      word-wrap: break-word;\r\n    }\r\n\r\n    @media (max-width: 600px) {\r\n      table, tbody, tr, td {\r\n        display: block;\r\n        width: 100%;\r\n      }\r\n\r\n      td {\r\n        margin-bottom: 10px;\r\n        border: none;\r\n      }\r\n    }\r\n  </style><p>Hier lernen Sie:</p>\r\n\r\n<ul>\r\n\t<li>Vorstellungen verstehen</li>\r\n</ul>\r\n\r\n<p>&Uuml;bungen: 3<br />\r\nZeit: 45 min</p>\r\n\r\n<p>1. Lernen Sie zwei Deutschlerner kennen. Lesen Sie den Text und beantworten Sie Fragen zum Text in den &Uuml;bungen unten.</p>\r\n\r\n<table border="1" cellpadding="1" cellspacing="1" style="width:100%">\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td><img alt="" src="https://lms.germanroom.vn/images/khoa_hoc/junge_frau_flickr3177468665_Kennyrivas_240.jpg" style="height:240px; width:180px" /></td>\r\n\t\t\t<td>Hallo. Ich hei&szlig;e Maria. Ich bin 26 Jahre alt und Spanierin. Ich komme aus Madrid und habe dort BWL, also&nbsp;Betriebswirtschaft, studiert. Mein Schwerpunkt im Studium waren internationale&nbsp;Handelsbeziehungen\r\n\t\t\t<p>&ouml;konomische Kontakte zwischen zwei Partnern</p>\r\n\t\t\t. Da ist Deutsch nat&uuml;rlich wichtig! Ich habe schon w&auml;hrend des Studiums viel Deutsch gelernt, weil Deutschland, &Ouml;sterreich und die Schweiz wichtige Handelspartner f&uuml;r Spanien sind. 2008 war ich dann Erasmus-Studentin. Ich habe ein Semester an der Humboldt-Universit&auml;t in Berlin studiert. Der erste Monat an einer deutschen Universit&auml;t war schwer, weil ich noch nicht so gut Deutsch gesprochen habe. Aber sp&auml;ter wurde es leichter. Ich bin sogar ins Theater gegangen und habe es gut verstanden. In Berlin habe ich Thomas kennen gelernt. Im letzten Jahr haben wir geheiratet. Jetzt lebe ich in Berlin und arbeite bei der Firma &bdquo;Seiler&ldquo;. Sie produzieren B&uuml;rom&ouml;bel. Ich reise oft nach Spanien, weil &bdquo;Seiler&ldquo; dort viele M&ouml;bel verkauft</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td><img alt="" src="https://lms.germanroom.vn/images/khoa_hoc/junger_mann_flickr3125029673_EmeryCoPhoto_240.jpg" style="height:240px; width:180px" /></td>\r\n\t\t\t<td>Hi. Ich bin Alexander und wohne in Warschau, Polen. Ich habe schon in der Schule Deutsch gelernt. Meine Klasse hatte eine deutsche Partnerklasse in Leipzig. Jeder polnische Sch&uuml;ler hatte einen deutschen Partnersch&uuml;ler. Mein Partnersch&uuml;ler war Martin. Wir haben oft E-Mails geschrieben und sp&auml;ter auch telefoniert. In der zehnten Klasse haben wir die Partnerklasse besucht. Leipzig ist eine tolle Stadt mit vielen historischen Sehensw&uuml;rdigkeiten. Zum Beispiel das &quot;V&ouml;lkerschlachtdenkmal\r\n\t\t\t<p>Sehensw&uuml;rdigkeit in Leipzig</p>\r\n\t\t\t&quot;. Das ist ein langes Wort, oder? Ich mag die deutsche Sprache, weil man so lange W&ouml;rter&nbsp;basteln&nbsp;kann. Jetzt studiere ich Geschichte und Deutsch an der Warschauer Universit&auml;t. Nach dem Studium m&ouml;chte ich das in der Schule unterrichten. Warum Deutsch? Weil Polen und Deutschland Nachbarn sind und wir uns verstehen m&uuml;ssen. Nach Leipzig fahre ich jedes Jahr und besuche meinen Freund Martin.</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n\r\n<p>Beantworten Sie jetzt die Fragen zu den Texten in den&nbsp;<a href="https://de.deutsch-uni.com/lernplattform/inhalte/index.do?do=uebung&amp;sequ=de9cbefcf58ca98ad4597f21776b4d1" onclick="openAppletWindow()" target="sequence">&Uuml;bungen</a>.</p>\r\n';
