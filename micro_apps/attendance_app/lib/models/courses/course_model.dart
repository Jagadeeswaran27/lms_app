import 'dart:convert';

class CourseModel {
  final String courseId;
  final String courseTitle;
  final String imageUrl;
  final String shortDescription;
  final String aboutDescription;
  final List<String> batchDay;
  final String batchTime;
  final double amount;
  final int totalHours;
  final int? noOfRegistrations;
  final List<Map<String, String>>? students;

  CourseModel({
    required this.courseId,
    required this.courseTitle,
    required this.imageUrl,
    required this.shortDescription,
    required this.aboutDescription,
    required this.batchDay,
    required this.batchTime,
    required this.amount,
    required this.totalHours,
    this.noOfRegistrations,
    this.students,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
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
      noOfRegistrations: json['noOfRegistrations'] ?? 0,
      students: json['students'] ?? [],
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
      'students': students,
      'totalHours': totalHours,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
