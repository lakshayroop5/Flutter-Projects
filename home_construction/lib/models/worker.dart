class Worker {
  final String id;
  final String name;
  double totalAmount;
  final List<Transaction> transactions;

  Worker(
      {required this.id,
      required this.name,
      required this.totalAmount,
      required this.transactions});
}

class Transaction {
  final String id;
  final double amount;
  final DateTime date;
  final String description;

  Transaction({
    required this.id,
    required this.amount,
    required this.date,
    required this.description,
  });
}
