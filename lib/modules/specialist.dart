import 'package:spectrum_speak/modules/parent.dart';

class Specialist {
  final String userID;
  final String specialistID;
  final String userName;
  final String email;
  final String city;
  final String phone;
  final String photo;
  final UserCategory category;
  final String specialistCategory;
  final String birthDate;
  final double price;
  final bool admin;
  final String centerID;

  Specialist({
    required this.userID,
    required this.specialistID,
    required this.userName,
    required this.birthDate,
    required this.email,
    required this.city,
    required this.phone,
    this.photo = '',
    required this.category,
    required this.specialistCategory,
    required this.price,
    required this.admin,
    required this.centerID,
  });

  @override
  String toString() {
    return 'Specialist{userID: $userID, specialistID: $specialistID, specialistCategory: $specialistCategory, price: $price, userName: $userName, email: $email, city: $city, phone: $phone, photo: $photo, category: $category, Admin: $admin, CenterIS: $centerID}';
  }
}
