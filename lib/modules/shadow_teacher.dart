import 'package:spectrum_speak/modules/parent.dart';

class ShadowTeacher {
  final String userID;
  final String userName;
  final String email;
  final String city;
  final String phone;
  final String photo;
  final UserCategory category;
  final double salary;
  final String birthDate;
  final String availability;
  final String qualification;
  final String gender;

  ShadowTeacher({
    required this.userID,
    required this.salary,
    required this.birthDate,
    required this.availability,
    required this.qualification,
    required this.gender,
    required this.userName,
    required this.email,
    required this.city,
    required this.phone,
    this.photo = "images/prof.png",
    required this.category,
  });

  @override
  String toString() {
    return 'ShadowTeacher{userID: $userID, salary: $salary, birthDate: $birthDate, availability: $availability, qualification: $qualification, gender: $gender, userName: $userName, email: $email, city: $city, phone: $phone,  category: $category}';
  }
}
