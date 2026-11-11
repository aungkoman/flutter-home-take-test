class RewardEntity {
  int id;
  String name;
  String description;
  String imageUrl;
  String colorCode;
  int rewardPoints;

  RewardEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.colorCode,
    required this.rewardPoints,
  });
}
