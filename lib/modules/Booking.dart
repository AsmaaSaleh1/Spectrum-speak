class Booking {
  final int bookingID;
  final String parentName;
  final String childName;
  final String specialistName;
  final DateTime time;
  final String description;
  final String specialistImageUrl;
  final String parentImageUrl;
  const Booking(this.parentName, this.childName, this.specialistName, this.time,
      this.description, this.bookingID, this.specialistImageUrl, this.parentImageUrl);
  @override
  String toString() {
    return 'Booking{'
        'parentName: $parentName, '
        'childName: $childName, '
        'specialistName: $specialistName, '
        'time: $time, '
        'description: $description}';
  }
}
