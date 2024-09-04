import 'dart:convert';

class AdminCourseModel {
  final String courseId;
  final String courseTitle;
  final String imageUrl;
  final String shortDescription;
  final String aboutDescription;
  final List<String> batchDay;
  final String batchTime;
  final double amount;
  final int noOfRegistrations;
  final int totalHours;

  AdminCourseModel({
    required this.courseId,
    required this.courseTitle,
    required this.imageUrl,
    required this.shortDescription,
    required this.aboutDescription,
    required this.batchDay,
    required this.batchTime,
    required this.amount,
    required this.noOfRegistrations,
    required this.totalHours,
  });

  factory AdminCourseModel.fromJson(Map<String, dynamic> json) {
    return AdminCourseModel(
      courseId: json['courseId'],
      courseTitle: json['courseTitle'],
      imageUrl: json['imageUrl'],
      shortDescription: json['shortDescription'],
      aboutDescription: json['aboutDescription'],
      batchDay: (json['batchDay'] as List<dynamic>)
          .map((item) => item as String)
          .toList(),
      batchTime: json['batchTime'],
      amount: json['amount'].toDouble(),
      noOfRegistrations: json['noOfRegistrations'],
      totalHours: json['totalHours'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'courseTitle': courseTitle,
      'imageUrl': imageUrl,
      'shortDescription': shortDescription,
      'aboutDescription': aboutDescription,
      'batchDay': batchDay,
      'batchTime': batchTime,
      'amount': amount,
      'noOfRegistrations': noOfRegistrations,
      'totalHours': totalHours,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
