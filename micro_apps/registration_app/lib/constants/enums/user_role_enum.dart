enum UserRoleEnum { student, teacher }

extension UserRoleEnumExtension on UserRoleEnum {
  String get roleName {
    switch (this) {
      case UserRoleEnum.student:
        return 'Student';
      case UserRoleEnum.teacher:
        return 'Teacher';
      default:
        return '';
    }
  }
}
