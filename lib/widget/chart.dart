import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personalexpense/model/transaction.dart';
import 'package:personalexpense/widget/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalAmount += recentTransactions[i].amount;
        }
      }

      return {"day": DateFormat.E().format(weekDay), "amount": totalAmount};
    }).reversed.toList();
  }

  double get _totalSpending {
    return _groupedTransactions.fold(0.0, (r, c) {
      return r + c["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _groupedTransactions.map((tx) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      tx["day"],
                      tx["amount"],
                      _totalSpending == 0.0
                          ? 0.0
                          : (tx["amount"] as double) / _totalSpending),
                );
              }).toList(),
            )));
  }
}
