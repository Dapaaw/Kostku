import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import Wajib
import '/config/theme.dart';

class PropertyCard extends StatelessWidget {
  final String propertyId;
  final String imageUrl;
  final String title;
  final String location;
  final String price;
  final double rating;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const PropertyCard({
    super.key,
    required this.propertyId,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    required this.rating,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                // --- PERUBAHAN: CachedNetworkImage ---
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 200,
                  height: 120,
                  fit: BoxFit.cover,

                  // OPTIMASI: Resize gambar di memori agar hemat RAM
                  memCacheWidth: 600,

                  // Loading State
                  placeholder: (context, url) => Container(
                    width: 200,
                    height: 120,
                    color: klookSoftGray,
                    child: const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: klookOrange,
                        ),
                      ),
                    ),
                  ),

                  // Error State
                  errorWidget: (context, url, error) => Container(
                    width: 200,
                    height: 120,
                    color: klookSoftGray,
                    child: Icon(Icons.broken_image, size: 40, color: klookGray),
                  ),
                ),
                // -------------------------------------
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: klookOrange, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: klookBlack,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 12, color: klookGray),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: klookGray,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Start from',
                            style: TextStyle(
                              fontSize: 9,
                              color: klookGray,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            price,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: klookOrange,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: onFavoriteToggle,
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: klookOrange,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
