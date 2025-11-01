import 'package:flutter/material.dart';
import '/data/models/kos_model.dart';

class FavoriteCard extends StatelessWidget {
  final KosModel kos;

  const FavoriteCard({super.key, required this.kos});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.favorite, color: Colors.red),
        title: Text(kos.name),
        subtitle: Text('${kos.location} • ⭐ ${kos.rating}'),
        trailing: Text('Rp${kos.price.toStringAsFixed(0)}'),
      ),
    );
  }
}
