import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../widgets/featured_article_card.dart';
import '../widgets/category_grid_item.dart';

class NewsDashboardScreen extends StatefulWidget {
  const NewsDashboardScreen({super.key});

  @override
  State<NewsDashboardScreen> createState() => _NewsDashboardScreenState();
}

class _NewsDashboardScreenState extends State<NewsDashboardScreen> {
  List<NewsArticle> _articles = List.from(sampleArticles);

  // Pull to refresh simulation
  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      _articles = List.from(_articles.reversed);
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Feed updated successfully!'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        edgeOffset: 120,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // Collapsing Header with Image
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              actions: [
                IconButton(
                  tooltip: 'Travel Dashboard',
                  icon: const Icon(Icons.flight_takeoff),
                  onPressed: () => Navigator.pushNamed(context, '/travel'),
                ),
                IconButton(
                  tooltip: 'Profile & Posts',
                  icon: const Icon(Icons.account_circle_outlined),
                  onPressed: () => Navigator.pushNamed(context, '/profile'),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Media Pulse',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=900',
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, stack) =>
                          Container(color: Colors.blueGrey),
                    ),
                    Container(color: Colors.black.withOpacity(0.35)),
                  ],
                ),
              ),
            ),

            // Section: Featured Story
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
                child: Text(
                  'Featured Headline',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: FeaturedArticleCard(article: _articles.first),
            ),

            // Section: Category Header
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                child: Text(
                  'Explore Categories',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // SliverGrid: Categories
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      CategoryGridItem(category: sampleCategories[index]),
                  childCount: sampleCategories.length,
                ),
              ),
            ),

            // Section: Latest Feed Header
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 8.0),
                child: Text(
                  'Latest News Feed',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // SliverList: News Articles with ListTile
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final article = _articles[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 4.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10.0),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          article.imageUrl,
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, err, stack) => Container(
                            width: 72,
                            height: 72,
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.broken_image),
                          ),
                        ),
                      ),
                      title: Text(
                        article.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Row(
                          children: [
                            Text(
                              article.category,
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              article.time,
                              style: const TextStyle(fontSize: 11.0),
                            ),
                          ],
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Reading: ${article.title}'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  );
                },
                childCount: _articles.length,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24.0)),
          ],
        ),
      ),
    );
  }
}