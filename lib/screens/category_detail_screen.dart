import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plant_nursery/models/product.dart';
import 'package:plant_nursery/screens/add_product_screen.dart';
import 'package:plant_nursery/screens/product_detail_screen.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String categoryName;

  CategoryDetailScreen({required this.categoryName});

  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  List<Product> products = [];
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productData = prefs.getStringList(widget.categoryName);

    if (productData != null) {
      setState(() {
        products = productData
            .map((item) => Product.fromJson(json.decode(item)))
            .toList();
        filteredProducts = products;
      });
    } else {
      // If no products are saved, load initial products
      products = getProductsForCategory(widget.categoryName);
      filteredProducts = products;
    }
  }

  Future<void> _saveProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productData =
        products.map((item) => json.encode(item.toJson())).toList();
    await prefs.setStringList(widget.categoryName, productData);
  }

  void _filterProducts(String query) {
    final filtered = products.where((product) {
      final productNameLower = product.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return productNameLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredProducts = filtered;
    });
  }

  void _addProduct(Product product) {
    setState(() {
      products.add(product);
      filteredProducts = products;
      _saveProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 118, 202, 119),
        title: Text(widget.categoryName),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(products: products),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProductScreen(
                    categoryName: widget.categoryName,
                    onAddProduct: _addProduct,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () =>
                  _navigateToProductDetail(context, filteredProducts[index]),
              child: ProductCard(product: filteredProducts[index]),
            );
          },
        ),
      ),
    );
  }

  void _navigateToProductDetail(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }

  List<Product> getProductsForCategory(String categoryName) {
    switch (categoryName) {
      case 'Saplings':
        return [
          Product(
            id: '1',
            name: 'Carrot Sapling',
            imageUrl: 'images/sapling1.jpg',
            description: 'A young tree sapling.',
            price: 10.0,
            Height: '30 cm', // Add height
            age: '2 months', // Add age
          ),
          Product(
            id: '2',
            name: 'Watermelon Sapling',
            imageUrl: 'images/sapling2.jpg',
            description: 'A young tree sapling.',
            price: 15.0,
            Height: '3m', // Add height
            age: '5 months', // Add age
          ),
        ];
      case 'Seeds':
        return [
          Product(
            id: '3',
            name: 'Carrot Seeds',
            imageUrl: 'images/seed1.jpeg',
            description: 'A pack of carrot seeds.',
            price: 5.0,
          ),
          Product(
            id: '4',
            name: 'Pumpkin Seeds',
            imageUrl: 'images/seed2.jpeg',
            description: 'A pack of pumpkin seeds.',
            price: 7.0,
          ),
        ];
      case 'Agricultural Clay':
        return [
          Product(
            id: '5',
            name: 'Dark Clay',
            imageUrl: 'images/clay1.jpg',
            description: 'High quality dark agricultural clay.',
            price: 20.0,
          ),
          Product(
            id: '6',
            name: 'Red Clay',
            imageUrl: 'images/clay2.jpg',
            description: 'High quality red agricultural clay.',
            price: 25.0,
          ),
        ];
      default:
        return [];
    }
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.file(File(product.imageUrl)),
        title: Text(product.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.description),
            if (product.Height != null) Text('Height: ${product.Height}'),
            if (product.age != null) Text('Age: ${product.age}'),
          ],
        ),
        trailing: Text('\$${product.price.toString()}'),
      ),
    );
  }
}

class ProductSearchDelegate extends SearchDelegate {
  final List<Product> products;

  ProductSearchDelegate({required this.products});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = products.where((product) {
      final productNameLower = product.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return productNameLower.contains(searchLower);
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetailScreen(product: results[index]),
              ),
            );
          },
          child: ProductCard(product: results[index]),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = products.where((product) {
      final productNameLower = product.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return productNameLower.contains(searchLower);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            query = suggestions[index].name;
            showResults(context);
          },
          child: ListTile(
            title: Text(suggestions[index].name),
          ),
        );
      },
    );
  }
}
