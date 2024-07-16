import 'package:flutter/material.dart';
import 'category_detail_screen.dart';
import 'user_account_screen.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Adjust padding as needed
          child: Image.asset('images/logo-removebg-preview.png'),
        ), // Path to your image
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              // Navigate to the user account screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserAccountScreen()),
              );
            },
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        title: Text(
          "PLANT NURSERY",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 118, 202, 119),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ProductCategory(
                categoryName: 'Saplings',
                imagePath: 'images/saplings.jpeg',
                onTap: () => _navigateToCategoryDetail(context, 'Saplings'),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ProductCategory(
                categoryName: 'Seeds',
                imagePath: 'images/seeds.png',
                onTap: () => _navigateToCategoryDetail(context, 'Seeds'),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ProductCategory(
                categoryName: 'Agricultural Clay',
                imagePath: 'images/clay.jpg',
                onTap: () =>
                    _navigateToCategoryDetail(context, 'Agricultural Clay'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCategoryDetail(BuildContext context, String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetailScreen(categoryName: categoryName),
      ),
    );
  }
}

class ProductCategory extends StatelessWidget {
  final String categoryName;
  final String imagePath;
  final VoidCallback onTap;

  const ProductCategory({
    required this.categoryName,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  categoryName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
