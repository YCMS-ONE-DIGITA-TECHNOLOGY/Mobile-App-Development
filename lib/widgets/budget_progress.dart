import 'package:flutter/material.dart';
import 'glass_card.dart';

class BudgetProgress extends StatelessWidget {
  final double spent;
  final double total;

  const BudgetProgress({
    super.key,
    required this.spent,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the percentage of budget used
    double progress = spent / total;
    // Cap the progress at 1.0 to prevent layout crashes
    if (progress > 1.0) progress = 1.0;
    if (progress < 0.0) progress = 0.0;

    // Determine the color based on spending levels
    Color progressColor = Colors.cyanAccent;
    if (progress > 0.7 && progress <= 0.9) {
      progressColor = Colors.orangeAccent;
    } else if (progress > 0.9) {
      progressColor = Colors.redAccent;
    }

    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Monthly Budget",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                Text(
                  "${(progress * 100).toStringAsFixed(0)}%",
                  style: TextStyle(color: progressColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // The Progress Bar
            Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  height: 8,
                  width: (MediaQuery.of(context).size.width - 80) * progress,
                  decoration: BoxDecoration(
                    color: progressColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: progressColor.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  "₹${spent.toStringAsFixed(0)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  " / ₹${total.toStringAsFixed(0)}",
                  style: const TextStyle(color: Colors.white54, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}