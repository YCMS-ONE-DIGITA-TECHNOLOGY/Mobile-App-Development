import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/expense_model.dart';

class ExpenseProvider with ChangeNotifier {
  List<ExpenseModel> _expenses = [];
  double _monthlyBudget = 30000.0;

  List<ExpenseModel> get expenses => _expenses;
  double get monthlyBudget => _monthlyBudget;
  double get totalSpent => _expenses.fold(0, (sum, item) => sum + item.amount);

  ExpenseProvider() {
    loadData();
  }

  // ADVANCED: Dynamic category filtering
  double getCategoryTotal(String categoryName) {
    return _expenses
        .where((item) => item.category == categoryName)
        .fold(0, (sum, item) => sum + item.amount);
  }

  void addExpense(ExpenseModel expense) {
    _expenses.insert(0, expense);
    notifyListeners();
    saveData();
  }

  // --- PERSISTENCE ---
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(
      _expenses.map((item) => {
        'id': item.id,
        'title': item.title,
        'amount': item.amount,
        'date': item.date.toIso8601String(),
        'category': item.category, // Save the tag
      }).toList(),
    );
    await prefs.setString('expense_data', encodedData);
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString('expense_data');
    if (savedData != null) {
      final List<dynamic> decodedData = json.decode(savedData);
      _expenses = decodedData.map((item) => ExpenseModel(
        id: item['id'],
        title: item['title'],
        amount: item['amount'],
        date: DateTime.parse(item['date']),
        category: item['category'] ?? 'Other',
      )).toList();
      notifyListeners();
    }
  }
}