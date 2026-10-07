class Quote {
  final String content;
  final String author;
  final String category;

  const Quote({
    required this.content,
    required this.author,
    required this.category,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      content: json['quote'] ?? json['content'] ?? 'No quote content available.',
      author: json['author'] ?? 'Unknown Author',
      category: json['category'] ?? 'General',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'author': author,
      'category': category,
    };
  }
}