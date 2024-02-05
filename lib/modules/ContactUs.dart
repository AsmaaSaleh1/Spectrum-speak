class Contact {
  final String contactID;
  final String userID;
  final String userName;
  final String contact;
  late int done;
  final DateTime dateTime;

  Contact(
    this.contactID,
    this.userID,
    this.userName,
    this.contact,
    this.done,
    this.dateTime,
  );

  @override
  String toString() {
    return 'Contact{contactID: $contactID, userID: $userID, userName: $userName, contact: $contact, done: $done, dateTime: $dateTime}';
  }
}
