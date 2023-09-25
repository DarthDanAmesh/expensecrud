import 'package:flutter/material.dart';
import 'package:expenseapp/transaction_list.dart';
import 'package:expenseapp/transaction.dart';
import 'package:expenseapp/new_transaction.dart';


//this is a short hand way for writing functions

void main() => runApp(MyApp());

// stateless widget cannot rebuild itself, unless from external events
class MyApp extends StatelessWidget {
  // we override the build method from statelesswidget class
  // we return any widget (here we return MaterialApp widget/class)
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      // the title, & home are named arguments for MaterialApp class/widget. The arrangement or order does not matter
      title: 'MoneyTrail',
      home: MyHomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
          accentColor: Colors.black,
        ),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            titleLarge : TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
          ),
          ),
      ),
    );
  }
}

// stateful widget can rebuild itself
class MyHomePage extends StatefulWidget{
  // private variables, methods, and classes are formed through _(underscore)
  _MyHomePageState createState() => _MyHomePageState();

}

// data defined here
class _MyHomePageState extends State<MyHomePage>{
  // using dummy or demo list to demonstrate
  final List<Transaction> _userTransactions = [
    // Transaction(id: '1', title: 'Laptop', amount: 600, date: DateTime.now()),
    // Transaction(id: '2', title: 'iPhone', amount: 500, date: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount, DateTime chosenDate){
    final newTx = Transaction(title: title, amount: amount, id: DateTime.now().toString(), date: chosenDate);

    setState(() {
      this._userTransactions.add(newTx);
    });
  }

  // comes from material.dart
  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return NewTransaction(this._addNewTransaction);
    });
  }


  // add a function into our file to pass the constructor of the transactions_list.dart file
  void _deleteTransaction(String id){
    // setState will re-render the class or widget
    setState(() {
      this._userTransactions.removeWhere((tx) => id == tx.id);
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense App',
        ),
        actions: <Widget>[

          // this is a plus sign on the top app bar title (top right)
          IconButton(
            icon: Icon(Icons.add),
            // call the function to open modal, when plus sign is tapped
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        // child for scroll view
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TransactionList(this._userTransactions, this._deleteTransaction)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),),

    );
  }
}