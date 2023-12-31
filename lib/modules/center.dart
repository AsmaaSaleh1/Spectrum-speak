class CenterAutism {
  final String centerID;
  final String centerName;
  final String email;
  final String phone;
  final String description;
  final String city;

  CenterAutism({
    required this.centerID,
    required this.centerName,
    required this.email,
    required this.phone,
    required this.description,
    required this.city,
  });

  @override
  String toString() {
    return 'Center{centerID: $centerID, centerName: $centerName, email: $email, phone: $phone, description: $description, city: $city}';
  }
}
