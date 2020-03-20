class Transaction {
  String id;
  String title;
  double amount;
  DateTime date;

  Transaction({this.id, this.title, this.amount, this.date});

  @override
  String toString() {
    return 'Transaction{id: $id, title: $title, amount: $amount, date: $date}';
  }
}