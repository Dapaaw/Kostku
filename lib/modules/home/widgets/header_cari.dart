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
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: klookGray, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      controller.updateSearchQuery(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Searching ?',
                      hintStyle: TextStyle(
                        color: klookGray,
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
                      color: klookOrange,
                      borderRadius: BorderRadius.circular(8),
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
                      color: klookBlack,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: onSeeAllPressed,
                style: TextButton.styleFrom(
                  foregroundColor: klookOrange,
                  padding: EdgeInsets.zero,
                ),
                child: const Text(
                  'See All >',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: klookOrange,
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
            init: controller,
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
                            ? klookOrange
                            : Colors.white,
                        foregroundColor: isSelected
                            ? Colors.white
                            : klookBlack,
                        elevation: isSelected ? 2 : 0,
                        shadowColor: Colors.black.withValues(alpha: 0.1),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: isSelected
                                ? klookOrange
                                : klookSoftGray,
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
