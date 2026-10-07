class NewsArticle {
  final String id;
  final String title;
  final String source;
  final String time;
  final String category;
  final String imageUrl;

  const NewsArticle({
    required this.id,
    required this.title,
    required this.source,
    required this.time,
    required this.category,
    required this.imageUrl,
  });
}

class CategoryItem {
  final String title;
  final String icon;
  final int count;

  const CategoryItem({
    required this.title,
    required this.icon,
    required this.count,
  });
}

const List<CategoryItem> sampleCategories = [
  CategoryItem(title: 'Technology', icon: '💻', count: 42),
  CategoryItem(title: 'Business', icon: '📈', count: 28),
  CategoryItem(title: 'Science', icon: '🔬', count: 19),
  CategoryItem(title: 'Sports', icon: '⚽', count: 35),
];

const List<NewsArticle> sampleArticles = [
  NewsArticle(
    id: 'a1',
    title: 'Breakthrough in Quantum Processing Speeds Up Complex Computing',
    source: 'Tech Daily',
    time: '2 hours ago',
    category: 'Technology',
    imageUrl: 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=500',
  ),
  NewsArticle(
    id: 'a2',
    title: 'Global Markets Adapt to Emerging Clean Energy Infrastructure',
    source: 'Financial Observer',
    time: '3 hours ago',
    category: 'Business',
    imageUrl: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=500',
  ),
  NewsArticle(
    id: 'a3',
    title: 'Deep Space Telescope Captures High-Res Images of Stellar Nursery',
    source: 'Cosmos Review',
    time: '5 hours ago',
    category: 'Science',
    imageUrl: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=500',
  ),
  NewsArticle(
    id: 'a4',
    title: 'National Tournament Concludes With Dramatic Final-Minute Goal',
    source: 'Sports Hub',
    time: '6 hours ago',
    category: 'Sports',
    imageUrl: 'https://images.unsplash.com/photo-1508098682722-e99c43a406b2?w=500',
  ),
];