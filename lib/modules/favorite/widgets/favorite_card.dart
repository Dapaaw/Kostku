import 'package:flutter/material.dart';
import '../../../data/models/kos_model.dart';

class FavoriteCard extends StatelessWidget {
  final KosModel hotel;

  const FavoriteCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.favorite, color: Colors.red),
        title: Text(hotel.name),
        subtitle: Text('${hotel.location} • ⭐ ${hotel.rating}'),
        trailing: Text('Rp${hotel.price.toStringAsFixed(0)}'),
      ),
    );
  }
}
