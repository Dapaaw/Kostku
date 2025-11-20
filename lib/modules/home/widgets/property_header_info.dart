import 'package:flutter/material.dart';
import '/config/theme.dart';
import '/data/models/kos_model.dart';
import '/config/formatter.dart';

class PropertyHeaderInfo extends StatelessWidget {
  final KosModel property;
  final Color primaryColor;

  const PropertyHeaderInfo({
    super.key,
    required this.property,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          property.name,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              currencyFormatter
                  .format(property.price.toDouble())
                  .split(',')[0],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(width: 16),
            const Icon(
              Icons.location_on_outlined,
              color: klookGray,
              size: 18,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                property.location,
                style: const TextStyle(
                  fontSize: 16,
                  color: klookGray,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
