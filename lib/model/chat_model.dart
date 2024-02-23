class ChatModel {
  String name;
  int id;
  String icon;
  bool? isGroup;
  String? time;
  String? currentMessage;
  String? status;
  bool? selected;
  ChatModel(
      {required this.name,
      required this.icon,
      this.isGroup,
      this.time,
      this.currentMessage,
      this.status,
      this.selected,
      required this.id});
}
