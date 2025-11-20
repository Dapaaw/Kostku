import 'package:flutter/material.dart';
import '/config/theme.dart';

class PropertyStatisticsRow extends StatelessWidget {
  final int bedrooms;
  final int bathrooms;
  final int kitchen;
  final Color backgroundColor;

  const PropertyStatisticsRow({
    super.key,
    required this.bedrooms,
    required this.bathrooms,
    required this.kitchen,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatItem(
          Icons.bed_outlined,
          '$bedrooms Beds',
          backgroundColor,
        ),
        _buildStatItem(
          Icons.bathtub_outlined,
          '$bathrooms Baths',
          backgroundColor,
        ),
        _buildStatItem(
          Icons.kitchen_outlined,
          '$kitchen Kitchen',
          backgroundColor,
        ),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String label, Color bgColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: klookGray, size: 28),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: klookBlack,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
