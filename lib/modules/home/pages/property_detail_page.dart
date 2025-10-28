import 'package:flutter/material.dart';

class PropertyDetailPage extends StatelessWidget {
  final String propertyId;
  const PropertyDetailPage({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Property ID: $propertyId', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text('Here you can show full information about the property, images, amenities, contact, and booking options.'),
          ],
        ),
      ),
    );
  }
}
