class Message {
  Message({
    required this.toID,
    required this.read,
    required this.type,
    required this.message,
    required this.sent,
    required this.fromID,
  });
  late final int toID;
  late final String read;
  late final String type;
  late final String message;
  late final String sent;
  late final int fromID;

  Message.fromJson(Map<String, dynamic> json) {
    toID = int.parse(json['toID'].toString());
    read = json['read'].toString();
    type = json['type'].toString();
    message = json['message'].toString();
    sent = json['sent'].toString();
    fromID = int.parse(json['fromID'].toString());
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['toID'] = toID;
    _data['read'] = read;
    _data['type'] = type;
    _data['message'] = message;
    _data['sent'] = sent;
    _data['fromID'] = fromID;
    return _data;
  }
}

enum Type { text, image }
