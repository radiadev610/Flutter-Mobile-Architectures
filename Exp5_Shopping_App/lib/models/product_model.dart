class Product {
  final String id;
  final String title;
  final String category;
  final double price;
  final String description;
  final String imageUrl;

  const Product({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.description,
    required this.imageUrl,
  });
}

// Sample dataset
const List<Product> sampleProducts = [
  Product(
    id: 'p1',
    title: 'Wireless Headphones',
    category: 'Electronics',
    price: 2499.00,
    description: 'High-fidelity audio with active noise cancellation.',
    imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
  ),
  Product(
    id: 'p2',
    title: 'Smart Fitness Watch',
    category: 'Electronics',
    price: 3999.00,
    description: 'Track workouts, heart rate, and sleep quality 24/7.',
    imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500',
  ),
  Product(
    id: 'p3',
    title: 'Classic Denim Jacket',
    category: 'Fashion',
    price: 1899.00,
    description: '100% durable cotton denim with relaxed fit styling.',
    imageUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=500',
  ),
  Product(
    id: 'p4',
    title: 'Running Sneakers',
    category: 'Fashion',
    price: 2999.00,
    description: 'Breathable lightweight sneakers designed for long runs.',
    imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500',
  ),
  Product(
    id: 'p5',
    title: 'Ergonomic Desk Lamp',
    category: 'Home',
    price: 1299.00,
    description: 'Adjustable brightness levels with eye-protection warm lighting.',
    imageUrl: 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500',
  ),
  Product(
    id: 'p6',
    title: 'Ceramic Coffee Mug',
    category: 'Home',
    price: 499.00,
    description: 'Handmade minimalist matte finish stoneware mug.',
    imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=500',
  ),
];