import 'package:flutter/material.dart';

class PriceListPage extends StatelessWidget {
  const PriceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder list - you can replace with real data/source
    final items = List.generate(8, (i) => 'Property ${i + 1} - Rp ${(i + 1) * 250000}');

    return Scaffold(
      appBar: AppBar(title: const Text('All Prices')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // navigate to detail (using demo id)
              Navigator.pushNamed(context, '/property', arguments: {'id': 'prop_${index + 1}'});
            },
          );
        },
        separatorBuilder: (_, __) => const Divider(),
        itemCount: items.length,
      ),
    );
  }
}
