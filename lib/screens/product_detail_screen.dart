import 'package:flutter/material.dart';
import 'package:plant_nursery/models/product.dart';
import 'package:plant_nursery/data/global.dart';
import 'cart_screen.dart';
import '../models/cart_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isFavorite = false;
  int quantity = 1; // Initialize the quantity

  @override
  void initState() {
    super.initState();
    isFavorite = favoriteProducts.contains(widget.product);
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      favoriteProducts.add(widget.product);
    } else {
      favoriteProducts.remove(widget.product);
    }
  }

  void addToCart() {
    for (int i = 0; i < quantity; i++) {
      CartModel.addItem(widget.product);
    }
    setState(() {}); // Refresh the state to reflect changes in the cart
  }

  double getTotalPrice() {
    return widget.product.price * quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 118, 202, 119),
          title: Text(widget.product.name),
        ),
        body: SingleChildScrollView(
            // Added SingleChildScrollView
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Product details
              Image.asset(widget.product.imageUrl),
              SizedBox(height: 20),
              Text(widget.product.name),
              SizedBox(height: 10),
              Text(widget.product.description),
              if (widget.product.Height != null)
                Text('Height: ${widget.product.Height}'),
              if (widget.product.age != null)
                Text('Age: ${widget.product.age}'),
              Text(
                  'Price: \$${getTotalPrice().toStringAsFixed(2)}'), // Display total price
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: toggleFavorite,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) {
                          quantity--;
                        }
                      });
                    },
                  ),
                  Text(quantity.toString()),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: addToCart,
                child: Text('Add to Cart'),
              ),
              SizedBox(height: 100),
              Text('This is the detail page for ${widget.product.name}'),
            ],
          ),
        )));
  }
}
