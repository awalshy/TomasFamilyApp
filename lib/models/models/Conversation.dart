class ConversationModel {
  final List<dynamic> members;
  final DateTime lastRead;
  final String name;
  final String id;

  ConversationModel({
    this.name,
    this.lastRead,
    this.members,
    this.id
});
}