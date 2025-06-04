class OverviewModel {
  final String id;
  final String categoryName;
  final String categoryImg;
  OverviewModel({
    required this.id,
    required this.categoryName,
    required this.categoryImg,
  });
  factory OverviewModel.fromJson(Map<String, dynamic> json) {
    return OverviewModel(
      id: json['id'] ?? '',
      categoryName: json['category_name'] ?? '',
      categoryImg: json['category_img'] ?? '',
    );
  }
}

class KhoaHocModel {
  final String courseId;
  final String name;
  final String courseImg;
  final String categoryId;
  final String stt;

  KhoaHocModel({
    required this.courseId,
    required this.name,
    required this.courseImg,
    required this.categoryId,
    required this.stt,
  });

  factory KhoaHocModel.fromJson(Map<String, dynamic> json) {
    return KhoaHocModel(
      courseId: json['course_id'] ?? '',
      name: json['name'] ?? '',
      courseImg: json['course_img'] ?? '',
      categoryId: json['category_id'] ?? '',
      stt: json['stt'] ?? '',
    );
  }
}

class HocLieuModel {
  final String name;
  final String learningMaterialsId;
  final List<MenuModel> menuItems;

  HocLieuModel({
    required this.name,
    required this.learningMaterialsId,
    required this.menuItems,
  });

  factory HocLieuModel.fromJson(Map<String, dynamic> json) {
    return HocLieuModel(
      name: json['name'] ?? '',
      learningMaterialsId: json['learning_materials_id'] ?? '',
      menuItems: List<MenuModel>.from(
        (json['menu'] as List).map(
          (e) => MenuModel.fromJson(e),
        ),
      ),
    );
  }
}

class MenuModel {
  final String name;
  final String sortBy;
  final String learningMaterialId;
  final String partId;

  MenuModel({
    required this.name,
    required this.sortBy,
    required this.learningMaterialId,
    required this.partId,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      name: json['name'] ?? '',
      sortBy: json['sort_by'] ?? '',
      learningMaterialId: json['learning_material_id'] ?? '',
      partId: json['part_id'].toString(),
    );
  }
}

class DetailLearingModel {
  final DetailLessonModel detailModel;
  final List<VideoModel> listVideo;
  final List<QuestionModel> listQuestion;

  DetailLearingModel({
    required this.detailModel,
    required this.listVideo,
    required this.listQuestion,
  });

  factory DetailLearingModel.fromJson(Map<String, dynamic> json) {
    return DetailLearingModel(
      detailModel: DetailLessonModel.fromJson(json['parts_learning_materials']),
      listVideo: List<VideoModel>.from(
        (json['video'] as List).map((e) => VideoModel.fromJson(e)),
      ),
      listQuestion: List<QuestionModel>.from(
        (json['question'] as List).map((e) => QuestionModel.fromJson(e)),
      ),
    );
  }
}

class QuestionModel {
  final String partLearningMaterialsId;
  final String questionsPartLearningMaterialId;
  final String title;

  QuestionModel({
    required this.partLearningMaterialsId,
    required this.questionsPartLearningMaterialId,
    required this.title,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      partLearningMaterialsId: json['part_learning_materials_id'] ?? '',
      questionsPartLearningMaterialId:
          json['questions_part_learning_material_id'] ?? '',
      title: json['title'] ?? '',
    );
  }
}

class VideoModel {
  final String name;
  final String link;
  final String type;

  VideoModel({
    required this.name,
    required this.link,
    required this.type,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      name: json['name'] ?? '',
      link: json['link'] ?? '',
      type: json['type'] ?? '',
    );
  }
}

class DetailLessonModel {
  final String id;
  final String name;
  final String detail;
  final String sortBy;

  DetailLessonModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.sortBy,
  });

  factory DetailLessonModel.fromJson(Map<String, dynamic> json) {
    return DetailLessonModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      detail: json['detail'] ?? '',
      sortBy: json['sort_by'] ?? '',
    );
  }
}
