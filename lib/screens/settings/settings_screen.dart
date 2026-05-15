import 'package:flutter/material.dart';
import '../../widgets/glass_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const GlassCard(
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.person_outline)),
                title: Text("Manasvi Kadu"),
                subtitle: Text("manasvi.kadu@college.edu"),
              ),
            ),
            const SizedBox(height: 30),
            _buildSettingToggle("Dark Mode", true),
            _buildSettingToggle("Biometric Lock", false),
            _buildSettingToggle("Push Notifications", true),
            const Spacer(),
            const Text("Lumina v1.0.0", style: TextStyle(color: Colors.white24)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingToggle(String title, bool value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GlassCard(
        opacity: 0.03,
        child: SwitchListTile(
          title: Text(title, style: const TextStyle(color: Colors.white70)),
          value: value,
          onChanged: (val) {},
          activeColor: Colors.cyanAccent,
        ),
      ),
    );
  }
}