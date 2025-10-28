class KosModel {
  final int id;
  final String name;
  final String location;
  final double price;
  final String imageUrl;
  final double rating;

  final List<String> galleryImageUrls;
  final int bedrooms;
  final int bathrooms;
  final int kitchen;
  final String description;

  KosModel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.rating,

    this.galleryImageUrls = const [],
    this.bedrooms = 0,
    this.bathrooms = 0,
    this.kitchen = 0,
    this.description =
        'Deskripsi lengkap untuk properti ini belum tersedia. Silakan hubungi pemilik untuk informasi lebih lanjut.',
  });

  factory KosModel.fromJson(Map<String, dynamic> json) {
    return KosModel(
      id: json['id'],
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),

      galleryImageUrls: List<String>.from(json['galleryImageUrls'] ?? []),
      bedrooms: json['bedrooms'] ?? 6,
      bathrooms: json['bathrooms'] ?? 2,
      kitchen: json['kitchen'] ?? 1,
      description: json['description'] ?? 'Deskripsi lengkap untuk properti ini belum tersedia. Silakan hubungi pemilik untuk informasi lebih lanjut.',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'location': location,
    'price': price,
    'imageUrl': imageUrl,
    'rating': rating,

    'galleryImageUrls': galleryImageUrls,
    'bedrooms': bedrooms,
    'bathrooms': bathrooms,
    'kitchen': kitchen,
    'description': description,
  };
}
