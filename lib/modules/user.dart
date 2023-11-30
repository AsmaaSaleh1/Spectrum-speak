
enum UserCategory { Parent, Specialist, ShadowTeacher }

class User {
  final String userID;
  final String userName;
  final String email;
  final String password;
  final String city;
  final String phone;
  final String photo;
  final UserCategory category;

  User({
    required this.userID,
    required this.userName,
    required this.email,
    required this.password,
    required this.city,
    required this.phone,
    required this.photo,
    required this.category,
  });


}
