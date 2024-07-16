import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../models/product.dart';
import 'user_info_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (Product product in CartModel.cartItems) {
      totalPrice += product.price;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Cart'),
        backgroundColor: Color.fromARGB(255, 118, 202, 119),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: CartModel.cartItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(CartModel.cartItems[index].name),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        setState(() {
                          CartModel.removeItem(CartModel.cartItems[index]);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            if (CartModel.cartItems.isNotEmpty)
              Text(
                'Total Price: \$${calculateTotalPrice().toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            SizedBox(height: 10),
            if (CartModel.cartItems.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  List<Product> orderItems = List.from(CartModel.cartItems);
                  setState(() {
                    CartModel.clearCart(); // Clear the cart
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserInfoScreen(orderItems: orderItems),
                    ),
                  ).then((_) {
                    setState(() {}); // Refresh the UI
                  });
                },
                child: Text('Shop Now'),
              ),
            SizedBox(height: 10),
            if (CartModel.cartItems.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    CartModel.clearCart();
                  });
                },
                child: Text('Clear Cart'),
              ),
          ],
        ),
      ),
    );
  }
}
