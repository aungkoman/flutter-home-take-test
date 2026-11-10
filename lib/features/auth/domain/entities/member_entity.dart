
class MemberEntity{
  int id;
  String name;
  String description;
  String imageUrl;
  int memberPoints;
  DateTime createdAt;
  DateTime updatedAt;

  MemberEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.memberPoints,
    required this.createdAt,
    required this.updatedAt
  });

  static MemberEntity get sample{
    return MemberEntity(
      id: 0,
      name:"name",
      description:"description",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      imageUrl: '',
      memberPoints: 0,
    );
  }
}