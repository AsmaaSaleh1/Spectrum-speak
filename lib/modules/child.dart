class Child{
  final String childID;
  final String userID;
  final String childName;
  final String birthDate;
  final String gender;
  final String photo;
  final String degreeOfAutism;

  Child({
    required this.childID,
    required this.userID,
    required this.childName,
    required this.birthDate,
    required this.gender,
    this.photo= '',
    required this.degreeOfAutism,
  });
}