class ProfileModel {
  final String id;
  final String code;
  final String fullName;
  final String phone;
  final String email;
  final String dob;
  final String img;
  final String address;
  final String targetIelts;
  final int? totalCustomerScore;
  ProfileModel({
    required this.id,
    required this.code,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.dob,
    required this.img,
    required this.address,
    required this.targetIelts,
    this.totalCustomerScore,
  });
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      dob: json['dob'] ?? '',
      img: json['img'] ?? '',
      address: json['address'] ?? '',
      targetIelts: json['target_ielts'] ?? '',
      totalCustomerScore: json['total_customer_score'],
    );
  }
}

class PostModel {
  final String id;
  final String name;
  final String slug;
  final String categories;
  final String img;
  final DateTime postDate;

  PostModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.categories,
    required this.img,
    required this.postDate,
  });
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      categories: json['categories'] ?? '',
      img: json['img'] ?? '',
      postDate: DateTime.parse(json['post_date'] ?? ''),
    );
  }
}

class DetailPostModel {
  final String id;
  final String postTitle;
  final String postName;
  final String guid;
  final String postContent;
  final DateTime postDate;
  final String thumbnail;
  final String categories;

  DetailPostModel(
      {required this.id,
      required this.postTitle,
      required this.postName,
      required this.guid,
      required this.postContent,
      required this.postDate,
      required this.thumbnail,
      required this.categories});
  factory DetailPostModel.fromJson(Map<String, dynamic> json) {
    return DetailPostModel(
      id: json['ID'] ?? '',
      postTitle: json['post_title'] ?? '',
      postName: json['post_name'] ?? '',
      guid: json['guid'] ?? '',
      postContent: json['post_content'] ?? '',
      postDate: DateTime.parse(json['post_date'] ?? ''),
      thumbnail: json['thumbnail'] ?? '',
      categories: json['categories'] ?? '',
    );
  }
}

class NotiModel {
  final String id;
  final String title;
  final String content;
  final String link;
  final String customerId;
  final String createdAt;

  NotiModel({
    required this.id,
    required this.title,
    required this.content,
    required this.link,
    required this.customerId,
    required this.createdAt,
  });
  factory NotiModel.fromJson(Map<String, dynamic> json) {
    return NotiModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      link: json['link'] ?? '',
      customerId: json['customer_id'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}

class PaymentModel {
  final String courseName;
  final String productName;
  final String totalPrice;
  final String totalPaid;
  final int tinhTrang;
  final int conthieu;
  PaymentModel({
    required this.courseName,
    required this.productName,
    required this.totalPrice,
    required this.totalPaid,
    required this.tinhTrang,
    required this.conthieu,
  });
  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      courseName: json['course_name'] ?? '',
      productName: json['product_name'] ?? '',
      totalPrice: json['total_amount'] ?? '',
      totalPaid: json['total_paid_amount'] ?? '',
      tinhTrang: json['tinh_trang_thanh_toan'] ?? '',
      conthieu: json['con_thieu'] ?? '',
    );
  }
}
