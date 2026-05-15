import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/budget_progress.dart';
import '../../providers/expense_provider.dart';
import '../../data/models/expense_model.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseData = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background Glow Orbs
          Positioned(
            top: -50,
            right: -50,
            child: _GlowOrb(color: Colors.deepPurple.withOpacity(0.5)),
          ),
          Positioned(
            bottom: 100,
            left: -80,
            child: _GlowOrb(color: Colors.cyan.withOpacity(0.3)),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildHeader(),
                  const SizedBox(height: 30),
                  
                  // Total Balance Glass Card
                  GlassCard(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Total Spent This Month", 
                            style: TextStyle(color: Colors.white70)),
                          const SizedBox(height: 8),
                          Text(
                            "₹${expenseData.totalSpent.toStringAsFixed(2)}", 
                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  
                  // Budget Progress Widget
                  BudgetProgress(
                    spent: expenseData.totalSpent, 
                    total: expenseData.monthlyBudget
                  ),

                  const SizedBox(height: 30),
                  const Text("Recent Expenses", 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
                  
                  // Transaction List
                  Expanded(
                    child: expenseData.expenses.isEmpty 
                    ? const Center(child: Text("No expenses yet!", style: TextStyle(color: Colors.white38)))
                    : ListView.builder(
                        itemCount: expenseData.expenses.length,
                        itemBuilder: (context, index) {
                          final item = expenseData.expenses[index];
                          return _buildTransactionTile(item);
                        },
                      ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Methods (Inside the DashboardScreen class) ---

  Widget _buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome back,", style: TextStyle(color: Colors.white60)),
            Text("Manasvi", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white10,
          child: Icon(Icons.person, color: Colors.white),
        )
      ],
    );
  }

  Widget _buildTransactionTile(ExpenseModel expense) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: GlassCard(
        opacity: 0.05,
        borderRadius: 15,
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.white10, 
            child: Icon(Icons.shopping_bag, color: Colors.cyan)
          ),
          title: Text(expense.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
          subtitle: Text(
            "${expense.date.day}/${expense.date.month}/${expense.date.year}", 
            style: const TextStyle(color: Colors.white54, fontSize: 12)
          ),
          trailing: Text(
            "-₹${expense.amount.toStringAsFixed(0)}", 
            style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)
          ),
        ),
      ),
    );
  }
}

// --- Background Widget (Outside the DashboardScreen class) ---

class _GlowOrb extends StatelessWidget {
  final Color color;
  const _GlowOrb({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color, 
            blurRadius: 100, 
            spreadRadius: 50,
          ),
        ],
      ),
    );
  }
}