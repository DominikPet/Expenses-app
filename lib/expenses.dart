import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/expenses_list.dart';
import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Flutter course",
        amount: 25.20,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "Hamburger",
        amount: 2.0,
        date: DateTime.now(),
        category: Category.food)
  ];

  void _addExpense(Expense exp) {
    setState(() {
      _registeredExpenses.add(exp);
      Navigator.pop(context);
    });
  }

  void _removeExpense(Expense exp) {
    final expenseIndex = _registeredExpenses.indexOf(exp);

    setState(() {
      _registeredExpenses.remove(exp);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(
                    expenseIndex, exp);
              });
            }),
        content: const Text("Expense deleted.")));
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(_addExpense);
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text("No expenses found. Start adding some."),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = width < 600 ? Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: ExpensesList(_registeredExpenses, _removeExpense))
        ],
      )
      : Row(
        children: [
          Expanded(child: Chart(expenses: _registeredExpenses)),
          Expanded(child: ExpensesList(_registeredExpenses, _removeExpense))
        ],
      );

    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Expense tracker"),
          actions: [
            IconButton(
                onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
          ],
        ),
        body: mainContent);
  }
}
