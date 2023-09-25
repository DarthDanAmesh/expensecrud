import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget{
  final addTx;

  // set up constructor
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState () => _NewTransactionState();

}

// Create our Transaction objects
class _NewTransactionState extends State<NewTransaction>{
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();


  // function to submit data
 void _submitData(){
   if (_amountController.text.isEmpty){
     return;
   }
   // set the value
   final enteredTitle = this._titleController.text;
   final enteredAmount = double.parse(this._amountController.text);

   // add form validations
   if(enteredTitle.isEmpty || enteredAmount <=0 || _selectedDate == null){
     return ;
   }

   // to submit, use the variables (like adding a object to list in python)
   widget.addTx(enteredTitle, enteredAmount, _selectedDate);

   // use pop to close the modal after submitting
   Navigator.of(context).pop();
 }

 // show datePicker function

  void _presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now())
        .then((pickedDate){
          if (pickedDate == null){
            return;
          }
          else {
            setState(() {
              this._selectedDate = pickedDate;
            });
          }
    });
  }

  @override
  Widget build(BuildContext context){
   return Card(
     // first item on card widget
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.end,
       children: <Widget>[

         // first textField
         TextField(
          decoration: InputDecoration(labelText: 'Title'),
           controller: _titleController,
           // use _(underscore) to avoid tamparing with the parameter
           onSubmitted: (_) => _submitData(),
         ),

         // second textField is the amount
         TextField(
           decoration: InputDecoration(labelText: 'Amount'),
           controller: _amountController,
           keyboardType: TextInputType.numberWithOptions(decimal: true),
           // use _(underscore) to avoid tamparing with the parameter
           onSubmitted: (_) => _submitData(),
         ),
         // third is a container,
         Container(
           height: 70,
           child: Row(
             children: <Widget>[
               Expanded(
                 child: Text(
                   _selectedDate == null
                       ? 'No date selected!'
                       : 'Selected Date: ${DateFormat.yMd().format(_selectedDate)}',
                 ),
               ),
               TextButton(
                 child: Text(
                   'Choose Date',
                   style: TextStyle(fontWeight: FontWeight.bold),
                 ),
                 onPressed: _presentDatePicker,
                 style: ButtonStyle(
                   foregroundColor: MaterialStateProperty.all(
                     Theme.of(context).primaryColor,
                   ),
                 ),
               ),
             ],
           ),
         ),
         ElevatedButton(
           onPressed: _submitData,
           style: ElevatedButton.styleFrom(
             foregroundColor: Colors.white,
             backgroundColor: Theme.of(context).primaryColor,
           ),
           child: Text('Add Transaction'),
         ),
       ],
     ),
   );
  }
}
