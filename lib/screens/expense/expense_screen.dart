import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/glass_card.dart';
import '../../providers/expense_provider.dart';
import '../../data/models/expense_model.dart';
import '../../core/utils/validators.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  
  // Tag System
  String _selectedCategory = 'Other';
  final List<String> _categories = ['Food', 'Shopping', 'Transport', 'Bills', 'Other'];

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      final newExpense = ExpenseModel(
        id: DateTime.now().toString(),
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        date: DateTime.now(),
        category: _selectedCategory, // Passing the selected tag
      );

      Provider.of<ExpenseProvider>(context, listen: false).addExpense(newExpense);
      
      _titleController.clear();
      _amountController.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Expense Added!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text("Add Transaction"), backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlassCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(labelText: "Description", labelStyle: TextStyle(color: Colors.white70)),
                        style: const TextStyle(color: Colors.white),
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Amount (₹)", labelStyle: TextStyle(color: Colors.white70)),
                        style: const TextStyle(color: Colors.white),
                        validator: AppValidators.validateAmount,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Text("Select Category Tag", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              // THE TAG SYSTEM
              Wrap(
                spacing: 10,
                children: _categories.map((cat) {
                  bool isSelected = _selectedCategory == cat;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      setState(() => _selectedCategory = cat);
                    },
                    selectedColor: Colors.cyanAccent,
                    labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.white),
                    backgroundColor: Colors.white10,
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("Save Transaction", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}