import 'package:spectrum_speak/modules/parent.dart';

class Specialist{
  final String specialistID;
  final String userID;
  final String specialistCategory;
  final double price;
  final String userName;
  final String email;
  final String password;
  final String city;
  final String phone;
  final String photo;
  final UserCategory category;

  Specialist({
    required this.specialistID,
    required this.userID,
    required this.specialistCategory,
    required this.price,
    required this.userName,
    required this.email,
    required this.password,
    required this.city,
    required this.phone,
    required this.photo,
    required this.category,
  });

  @override
  String toString() {
    return 'Specialist{specialistID: $specialistID, userID: $userID, specialistCategory: $specialistCategory, price: $price, userName: $userName, email: $email, password: $password, city: $city, phone: $phone, photo: $photo, category: $category}';
  }
}