import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransaction;

  NewTransaction(this._addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  DateTime txDate;

  void addTx() {
    final enteredText = titleController.text;
    final enteredAmount = amountController.text;

    if (enteredText.isEmpty || enteredAmount.isEmpty || txDate == null) {
      return;
    }

    widget._addTransaction(enteredText, double.parse(enteredAmount), txDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((chosenDate) {
      if (chosenDate == null) {
        return;
      }

      setState(() {
        txDate = chosenDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
              onSubmitted: (_) => addTx(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => addTx(),
            ),
            Container(
              height: 100,
              child: Row(
                children: <Widget>[
                  Text(txDate == null
                      ? "No Date Chosen"
                      : DateFormat.yMMMd().format(txDate)),
                  FlatButton(
                    child: Text(
                      "Choose Date",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _presentDatePicker,
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            FlatButton(
              child: Text("Add Transaction"),
              textColor: Theme.of(context).primaryColor,
              onPressed: addTx,
            )
          ],
        ),
      ),
    );
  }
}
