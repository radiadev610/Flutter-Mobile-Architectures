class ProductItem {
  final String id;
  final String title;
  final String tagLine;
  final double price;
  final String description;
  final String imageUrl;

  const ProductItem({
    required this.id,
    required this.title,
    required this.tagLine,
    required this.price,
    required this.description,
    required this.imageUrl,
  });
}

const List<ProductItem> catalogProducts = [
  ProductItem(
    id: 'prod_1',
    title: 'Aura Wireless Headphones',
    tagLine: 'Active Noise Cancelling',
    price: 3499.00,
    description: 'Immersive sound with 40-hour battery life, plush memory foam earcups, and dual beamforming microphones.',
    imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600',
  ),
  ProductItem(
    id: 'prod_2',
    title: 'Titan Smart Watch',
    tagLine: 'Fitness & GPS Tracker',
    price: 4999.00,
    description: 'Track workouts, blood oxygen, sleep phases, and receive instant notifications with a vivid AMOLED display.',
    imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600',
  ),
  ProductItem(
    id: 'prod_3',
    title: 'Urban Runner Pro',
    tagLine: 'Cushioned Footwear',
    price: 2799.00,
    description: 'Engineered breathable knit upper with dynamic responsiveness and durable rubber traction.',
    imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600',
  ),
];