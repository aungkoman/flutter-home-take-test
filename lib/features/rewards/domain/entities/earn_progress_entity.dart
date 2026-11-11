class EarnProgressEntity {
  const EarnProgressEntity({
    required this.userId,
    required this.earnId,
    required this.completedQuantity,
  });
  final int userId;
  final int earnId;
  final int completedQuantity;
}
