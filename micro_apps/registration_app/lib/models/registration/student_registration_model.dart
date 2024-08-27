class StudentRegistrationModel {
  final String courseName;
  final String courseId;
  final String registrationId;
  final String registeredBy;
  final String status;
  final String paymentStatus;
  final String imageUrl;
  final String registeredFor;

  StudentRegistrationModel({
    required this.courseName,
    required this.courseId,
    required this.registrationId,
    required this.registeredBy,
    required this.status,
    required this.paymentStatus,
    required this.imageUrl,
    required this.registeredFor,
  });

  factory StudentRegistrationModel.fromJson(Map<String, dynamic> json) {
    return StudentRegistrationModel(
      courseName: json['courseName'] as String,
      courseId: json['courseId'] as String,
      registrationId: json['registrationId'] as String,
      registeredBy: json['registeredBy'] as String,
      status: json['status'] as String,
      paymentStatus: json['paymentStatus'] as String,
      imageUrl: json['imageUrl'] as String,
      registeredFor: json['registeredFor'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseName': courseName,
      'courseId': courseId,
      'registrationId': registrationId,
      'registeredBy': registeredBy,
      'status': status,
      'paymentStatus': paymentStatus,
      'imageUrl': imageUrl,
      'registeredFor': registeredFor,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentRegistrationModel &&
          runtimeType == other.runtimeType &&
          courseName == other.courseName &&
          courseId == other.courseId &&
          registrationId == other.registrationId &&
          registeredBy == other.registeredBy &&
          status == other.status &&
          paymentStatus == other.paymentStatus &&
          imageUrl == other.imageUrl &&
          registeredFor == other.registeredFor;

  @override
  int get hashCode => Object.hash(
        courseName,
        courseId,
        registrationId,
        registeredBy,
        status,
        paymentStatus,
        imageUrl,
        registeredFor,
      );

  StudentRegistrationModel copyWith({
    String? courseName,
    String? courseId,
    String? registrationId,
    String? registeredBy,
    String? status,
    String? paymentStatus,
    String? imageUrl,
    String? registeredFor,
  }) {
    return StudentRegistrationModel(
      courseName: courseName ?? this.courseName,
      courseId: courseId ?? this.courseId,
      registrationId: registrationId ?? this.registrationId,
      registeredBy: registeredBy ?? this.registeredBy,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      imageUrl: imageUrl ?? this.imageUrl,
      registeredFor: registeredFor ?? this.registeredFor,
    );
  }
}
