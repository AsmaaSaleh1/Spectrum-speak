class ChatUser {
  ChatUser({
    this.image = '',
    this.createdAt = '',
    required this.Email,
    this.lastActive = '',
    required this.UserID,
    this.isOnline = false,
    this.pushToken = '',
    required this.Name,
  });
  late String image;
  late String createdAt;
  late final String Email;
  late String lastActive;
  late final int UserID;
  late bool isOnline;
  late String pushToken;
  late final String Name;

  ChatUser.fromJson(Map<String, dynamic>? json)
    : createdAt = json?['createdAt'] ?? '',
      image = json?['image'] ?? '',
      Email = json?['Email'] ?? '',
      lastActive = json?['lastActive'] ?? '',
      UserID = (json?['UserID'] ?? 0) as int, // Assuming UserID is an int
      isOnline = json?['isOnline'] ?? false,
      pushToken = json?['pushToken'] ?? '',
      Name = json?['Name'] ?? '';


  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['createdAt'] = createdAt;
    _data['Email'] = Email;
    _data['image'] = image;
    _data['lastActive'] = lastActive;
    _data['UserID'] = UserID;
    _data['isOnline'] = isOnline;
    _data['pushToken'] = pushToken;
    _data['Name'] = Name;
    return _data;
  }
}
