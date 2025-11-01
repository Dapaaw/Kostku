import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/config/theme.dart';
import '/data/models/kos_controller.dart';

class SearchAndFilterSection extends StatelessWidget {
  final VoidCallback onSeeAllPressed;

  const SearchAndFilterSection({super.key, required this.onSeeAllPressed});

  @override
  Widget build(BuildContext context) {
    final KosController controller = Get.find<KosController>();

    return Column(
      children: [
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
              children: [
                const Icon(Icons.search, color: Colors.grey, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      controller.updateSearchQuery(value);
                    },
                    decoration: const InputDecoration(
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
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: travelokaBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.attach_money,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: onSeeAllPressed,
                style: TextButton.styleFrom(
                  foregroundColor: travelokaBlue,
                  padding: EdgeInsets.zero,
                ),
                child: const Text(
                  'See All >',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: travelokaBlue,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
        SizedBox(
          height: 36,
          child: GetBuilder<KosController>(
            builder: (controller) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.priceRanges.length,
                itemBuilder: (context, index) {
                  final range = controller.priceRanges[index];
                  final isSelected = controller.selectedPriceRange == range;

                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: ElevatedButton(
                      onPressed: () => controller.updatePriceRange(range),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? travelokaBlue
                            : Colors.white,
                        foregroundColor: isSelected
                            ? Colors.white
                            : Colors.black87,
                        elevation: isSelected ? 2 : 0,
                        shadowColor: Colors.black.withOpacity(0.1),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected
                                ? travelokaBlue
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
              );
            },
          ),
        ),
      ],
    );
  }
}
