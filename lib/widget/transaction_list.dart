import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:personalexpense/model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              elevation: 10,
              child: ListTile(
                leading: CircleAvatar(
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text("€${_transactions[index].amount}"),
                    ),
                  ),
                  radius: 30,
                ),
                title: Text(_transactions[index].title),
                subtitle:
                    Text(DateFormat.yMMMd().format(_transactions[index].date)),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => _deleteTransaction(_transactions[index].id),
                ),
              ),
            );
          },
          itemCount: _transactions.length,
        ));
  }
}
