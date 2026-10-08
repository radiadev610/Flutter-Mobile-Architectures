class EventModel {
  final String id;
  final String title;
  final String category;
  final String date;
  final String location;
  final double price;
  final int totalSeats;
  final int availableSeats;
  final String imageUrl;
  final String description;

  EventModel({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.location,
    required this.price,
    required this.totalSeats,
    required this.availableSeats,
    required this.imageUrl,
    required this.description,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      category: json['category'] as String? ?? 'General',
      date: json['date'] as String? ?? '',
      location: json['location'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      totalSeats: json['totalSeats'] as int? ?? 100,
      availableSeats: json['availableSeats'] as int? ?? 100,
      imageUrl: json['imageUrl'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'date': date,
        'location': location,
        'price': price,
        'totalSeats': totalSeats,
        'availableSeats': availableSeats,
        'imageUrl': imageUrl,
        'description': description,
      };
}