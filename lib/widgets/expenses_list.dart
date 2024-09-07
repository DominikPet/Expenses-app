import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/widgets/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget{
  ExpensesList(this.expenses, this.removeExpense, {super.key});
  void Function(Expense exp) removeExpense;
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(key: ValueKey(expenses[index]),
      background: Container(alignment: Alignment.centerRight ,color: Theme.of(context).colorScheme.error.withAlpha(150), margin: Theme.of(context).cardTheme.margin,child: const Icon(Icons.delete_forever_sharp) ,),
      onDismissed: (direction) => 
      removeExpense(expenses[index]),
      child: ExpensesItem(expenses[index])),
    );
  }
  
}