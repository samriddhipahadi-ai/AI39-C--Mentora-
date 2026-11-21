
enum AccountRole {
  student,
  teacher,
  admin,
}

extension AccountRoleLabel on AccountRole {
  String get label {
    switch (this) {
      case AccountRole.student:
        return 'Student';

      case AccountRole.teacher:
        return 'Teacher';

      case AccountRole.admin:
        return 'Admin';
    }
  }
}
