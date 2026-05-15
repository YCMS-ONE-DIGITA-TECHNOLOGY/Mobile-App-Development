import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/glass_card.dart';
import '../../providers/expense_provider.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseData = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Analytics"), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GlassCard(
            child: Container(
              height: 180,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Total Monthly Spend", style: TextStyle(color: Colors.white70)),
                  Text("₹${expenseData.totalSpent.toStringAsFixed(2)}", 
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text("Category Breakdown", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 15),
          
          // DYNAMIC STAT TILES
          _buildCategoryStat(context, "Food", Colors.orangeAccent),
          _buildCategoryStat(context, "Shopping", Colors.purpleAccent),
          _buildCategoryStat(context, "Transport", Colors.blueAccent),
          _buildCategoryStat(context, "Bills", Colors.redAccent),
          _buildCategoryStat(context, "Other", Colors.grey),
        ],
      ),
    );
  }

  Widget _buildCategoryStat(BuildContext context, String category, Color color) {
    final total = Provider.of<ExpenseProvider>(context).getCategoryTotal(category);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        opacity: 0.05,
        child: ListTile(
          leading: CircleAvatar(backgroundColor: color.withOpacity(0.2), radius: 10),
          title: Text(category, style: const TextStyle(color: Colors.white)),
          trailing: Text("₹${total.toStringAsFixed(0)}", 
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}