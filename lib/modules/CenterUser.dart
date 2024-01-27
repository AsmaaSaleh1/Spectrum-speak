class CenterUser {
  CenterUser({
    required this.specialistID,
    required this.centerID,
    required this.image,
    required this.centerName,
  });
  late final String specialistID;
  late final String centerID;
  late final String image;
  late final String centerName;
  
  CenterUser.fromJson(Map<String, dynamic> json){
    specialistID = json['specialistID'];
    centerID = json['centerID'];
    image = json['image'];
    centerName = json['centerName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['specialistID'] = specialistID;
    _data['centerID'] = centerID;
    _data['image'] = image;
    _data['centerName'] = centerName;
    return _data;
  }
}