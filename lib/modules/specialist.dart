import 'package:spectrum_speak/modules/parent.dart';

class Specialist{
  final String userID;
  final String userName;
  final String email;
  final String city;
  final String phone;
  final String photo;
  final UserCategory category;
  final String specialistCategory;
  final double price;

  Specialist({
    required this.userID,
    required this.userName,
    required this.email,
    required this.city,
    required this.phone,
    this.photo= '',
    required this.category,
    required this.specialistCategory,
    required this.price,
  });

  @override
  String toString() {
    return 'Specialist{userID: $userID, specialistCategory: $specialistCategory, price: $price, userName: $userName, email: $email, city: $city, phone: $phone, photo: $photo, category: $category}';
  }
}