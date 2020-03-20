import "package:flutter/material.dart";
import 'package:personalexpense/model/transaction.dart';
import 'package:personalexpense/widget/user_transaction.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expense App",
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  Transaction inputTransaction = Transaction();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Personal Expense Manager"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                child: Card(
                  color: Colors.blue,
                  child: Text("Chart"),
                  elevation: 20,
                ),
              ),
              UserTransaction()
            ],
          ),
        ));
  }
}
