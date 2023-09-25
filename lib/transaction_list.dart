import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expenseapp/transaction.dart';

class TransactionList extends StatelessWidget{
  final List<Transaction> transactions;
  final Function deleteTx;


  // set up the constructor
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context){
    return Container(
      height: 550,
      // if there are no transactions present
      child: this.transactions.isEmpty ? Column(
        children: <Widget>[
          // first widget is a text
          Text(
            'There are no added transactions yet!',
            // ad  some style
            style: Theme.of(context).textTheme.titleLarge,
          ),
          // second widget is a sized box for vertical space
          SizedBox(
            height: 60,
          ),
          // third widget is a container
          Container(
            height: 400,
            // inside the third widget container,
            child: Image.asset('assets/images/waiting.png',
            fit: BoxFit.cover,
            ),
          ),
        ],
      ):
          // construct a list view here for the column widget, see it follows the colon sign ( Column : values)
      // the itemCount, makes it possible to create list based on demand,
      ListView.builder(
          itemBuilder: (ctx, index){
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),

              // add a child as the first item in the card, this is the ListTile
              child: ListTile(
                leading: CircleAvatar(radius: 30,
                // // the first item in the List tile
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  // inside the padding show the amount
                  child: FittedBox(child: Text('\$${transactions[index].amount}')),
                ),
                ),

                // the second item in the List tile is title of the transaction
                title: Text(
                  transactions[index].title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // third item in the List tile is showing the date of transaction
                subtitle: Text(

                  // DateFormat is from the intl library in the second dependency imported
                  DateFormat.yMMMd().format(transactions[index].date),
                  ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () => deleteTx(this.transactions[index].id),
                ),
              )
            );
          },
        itemCount: transactions.length,
      )
    );
  }
}