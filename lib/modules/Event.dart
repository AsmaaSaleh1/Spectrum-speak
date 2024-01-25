class Event {
  final String eventID;
  final String description;
  final String centerName;
  final String city;
  final DateTime time;
  final String image;

  Event({
    required this.eventID,
    required this.description,
    required this.time,
    required this.centerName,
    required this.city,
    required this.image,
  });
  @override
  String toString() {
    return 'ID: $eventID\nDescription: $description\nCenterName: $centerName\ntime: $time\ncity: $city';
  }
}
