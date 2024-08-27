enum UserRoleEnum { student, teacher, institute }

extension UserRoleEnumExtension on UserRoleEnum {
  String get roleName {
    switch (this) {
      case UserRoleEnum.student:
        return 'Student';
      case UserRoleEnum.teacher:
        return 'Teacher';
      case UserRoleEnum.institute:
        return 'Institute';
      default:
        return '';
    }
  }
}
