import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Center(
              child: CircleAvatar(
                radius: 46,
                backgroundColor: Colors.indigo,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 12.0),
            const Center(
              child: Text(
                'Dev Radia',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            const Center(
              child: Text(
                'dev@example.com',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24.0),
            Card(
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.shopping_bag_outlined),
                    title: Text('Order History'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                  Divider(height: 0),
                  ListTile(
                    leading: Icon(Icons.location_on_outlined),
                    title: Text('Saved Shipping Addresses'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                  Divider(height: 0),
                  ListTile(
                    leading: Icon(Icons.payment_outlined),
                    title: Text('Payment Methods'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}