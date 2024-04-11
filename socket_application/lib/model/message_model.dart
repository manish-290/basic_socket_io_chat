
// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message {
  String message;
  String sentByMe;
  Message({
    required this.message,
    required this.sentByMe,
  });


  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'] as String,
      sentByMe: json['sentByMe'] as String,
    );
  }


}
