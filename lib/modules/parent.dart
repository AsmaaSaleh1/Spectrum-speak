
enum UserCategory { Parent, Specialist, ShadowTeacher }

class Parent {
  final String userID;
  final String userName;
  final String email;
  final String city;
  final String phone;
  final String photo;
  final UserCategory category;

  Parent({
    required this.userID,
    required this.userName,
    required this.email,
    required this.city,
    required this.phone,
    this.photo= '',
    required this.category,
  });

  @override
  String toString() {
    return 'Parent{userID: $userID, userName: $userName, email: $email, city: $city, phone: $phone, photo: $photo, category: $category}';
  }
}
