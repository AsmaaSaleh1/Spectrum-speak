class BookingNotification {
  BookingNotification({
   this.toID,
   this.childID,
    this.childName,
  this.read,
   this.timeSent,
   this.timeOfBooking,
   this.type,
   this.fromID,
   this.value,
  });
  late String? toID;
  late String? childName;
  late String? childID;
  late bool? read;
  late String? timeSent;
  late String? timeOfBooking;
  late String? type;
  late String? fromID;
  late bool? value;
  
  BookingNotification.fromJson(Map<String, dynamic> json){
    toID = json['toID'];
    childName = json['childName'];
    childID = json['childID'];
    read = json['read'];
    timeSent = json['timeSent'];
    timeOfBooking = json['timeOfBooking'];
    type = json['type'];
    fromID = json['fromID'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['toID'] = toID;
    _data['childName'] = childName;
    _data['childID'] = childID;
    _data['read'] = read;
    _data['timeSent'] = timeSent;
    _data['timeOfBooking'] = timeOfBooking;
    _data['type'] = type;
    _data['fromID'] = fromID;
    _data['value'] = value;
    return _data;
  }
}