import 'package:flutter/material.dart';
import 'package:plant_nursery/models/product.dart';
import 'package:plant_nursery/data/global.dart';
import 'product_detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Product> displayedProducts = favoriteProducts;
  TextEditingController searchController = TextEditingController();

  void updateSearch(String query) {
    setState(() {
      displayedProducts = favoriteProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 118, 202, 119),
        title: Text('Favorites'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              onChanged: updateSearch,
            ),
          ),
          Expanded(
            child: displayedProducts.isEmpty
                ? Center(
                    child: Text('No favorites yet!'),
                  )
                : ListView.builder(
                    itemCount: displayedProducts.length,
                    itemBuilder: (context, index) {
                      final product = displayedProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailScreen(product: product),
                            ),
                          );
                        },
                        child: ProductCard(product: product),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(product.imageUrl),
        title: Text(product.name),
        subtitle: Text(product.description),
        trailing: Text('\$${product.price.toString()}'),
      ),
    );
  }
}
