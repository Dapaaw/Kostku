class HotelModel {
  final int id;
  final String name;
  final String location;
  final double price;
  final String imageUrl;
  final double rating; 

  HotelModel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.rating, 
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'],
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(), 
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'location': location,
        'price': price,
        'imageUrl': imageUrl,
        'rating': rating,
      };
}
