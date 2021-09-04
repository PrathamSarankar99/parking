class Transaction {
  final String id;
  final String userId;
  final double amount;
  final DateTime dateTime;
  final String gatewayId;

  Transaction({
    this.id,
    this.userId,
    this.amount,
    this.dateTime,
    this.gatewayId,
  });
}
