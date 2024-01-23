class CenterNotification {
  CenterNotification({
    required this.fromID,
    this.time,
    required this.toID,
    this.read,
    this.type,
    this.value,
  });
  late final String fromID;
  late String? time;
  late final String toID;
  late bool? read;
  late String? type;
  late bool? value;
  
  CenterNotification.fromJson(Map<String, dynamic> json){
    fromID = json['fromID'];
    time = json['time'];
    toID = json['toID'];
    read = json['read'];
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fromID'] = fromID;
    _data['time'] = time;
    _data['toID'] = toID;
    _data['read'] = read;
    _data['type'] = type;
    _data['value'] = value;
    return _data;
  }
}