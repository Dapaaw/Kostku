// Lokasi file: modules/home/widgets/search_and_filter_section.dart

import 'package:flutter/material.dart';

class SearchAndFilterSection extends StatelessWidget {
  final List<String> priceRanges;
  final String selectedPriceRange;
  final Function(String) onPriceRangeSelected;
  final VoidCallback onSeeAllPressed;

  const SearchAndFilterSection({
    Key? key,
    required this.priceRanges,
    required this.selectedPriceRange,
    required this.onPriceRangeSelected,
    required this.onSeeAllPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: const [
                Icon(Icons.search, color: Colors.grey, size: 22),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Searching ?',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Price',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: onSeeAllPressed, 
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey,
                  padding: EdgeInsets.zero,
                ),
                child: const Text(
                  'See All >',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Price Range Buttons
        SizedBox(
          height: 36,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: priceRanges.length, // Menggunakan data dari constructor
            itemBuilder: (context, index) {
              final range = priceRanges[index];
              final isSelected =
                  selectedPriceRange ==
                  range; // Menggunakan data dari constructor
              return Container(
                margin: const EdgeInsets.only(right: 8),
                child: ElevatedButton(
                  onPressed: () =>
                      onPriceRangeSelected(range), // Menggunakan callback
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected
                        ? const Color(0xFF0066FF)
                        : Colors.white,
                    foregroundColor: isSelected ? Colors.white : Colors.black87,
                    elevation: isSelected ? 2 : 0,
                    shadowColor: Colors.black.withOpacity(0.1),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? const Color(0xFF0066FF)
                            : Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    range,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
