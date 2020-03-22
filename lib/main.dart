import "package:flutter/material.dart";
import 'package:personalexpense/model/transaction.dart';
import 'package:personalexpense/widget/chart.dart';
import 'package:personalexpense/widget/new_transaction.dart';
import 'package:personalexpense/widget/transaction_list.dart';
import 'package:uuid/uuid.dart';

void main() => runApp(Main());

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.amber,
          fontFamily: "Quicksand"),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Transaction inputTransaction = Transaction();
  final List<Transaction> _userTransactions = [];

  void _addTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        id: Uuid().v1(), title: title, amount: amount, date: chosenDate);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String txId) {
    print("Removing id: ${txId}");
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == txId;
      });
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _startNewTx(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expense Manager"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startNewTx(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: Card(
                color: Theme.of(context).primaryColor,
                child: Chart(_recentTransactions),
                elevation: 20,
              ),
            ),
            TransactionList(_userTransactions, _deleteTransaction)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: IconButton(icon: Icon(Icons.add)),
        onPressed: () => _startNewTx(context),
      ),
    );
  }
}
