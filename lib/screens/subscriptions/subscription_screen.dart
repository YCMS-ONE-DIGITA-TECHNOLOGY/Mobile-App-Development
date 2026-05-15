import 'package:flutter/material.dart';
import '../../widgets/glass_card.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Subscriptions"), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSubItem("Netflix", "Premium Plan", "₹649", Colors.redAccent),
          _buildSubItem("Spotify", "Family Plan", "₹179", Colors.greenAccent),
          _buildSubItem("YouTube", "Premium", "₹129", Colors.red),
          _buildSubItem("Google One", "100 GB Storage", "₹130", Colors.blueAccent),
        ],
      ),
    );
  }

  Widget _buildSubItem(String title, String plan, String price, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: GlassCard(
        child: ListTile(
          leading: CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(Icons.repeat, color: color, size: 18)),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(plan, style: const TextStyle(fontSize: 12, color: Colors.white54)),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const Text("Monthly", style: TextStyle(fontSize: 10, color: Colors.cyanAccent)),
            ],
          ),
        ),
      ),
    );
  }
}