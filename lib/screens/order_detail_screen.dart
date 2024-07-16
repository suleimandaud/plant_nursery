import 'package:flutter/material.dart';
import 'package:plant_nursery/models/product.dart';
import 'package:plant_nursery/screens/home_screen.dart';
import 'package:plant_nursery/screens/main_screen.dart';
import '../main.dart';

class OrderDetailScreen extends StatelessWidget {
  final List<Product> orderItems;
  final String customerName;
  final String phoneNumber;
  final String location;
  final double totalPrice;

  OrderDetailScreen({
    required this.orderItems,
    required this.customerName,
    required this.phoneNumber,
    required this.location,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back arrow
        title: Text('Order Details'),
        backgroundColor: Color.fromARGB(255, 118, 202, 119),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer Name: $customerName'),
            SizedBox(height: 10),
            Text('Order Items:'),
            ...orderItems.map((item) => Text('- ${item.name}')).toList(),
            SizedBox(height: 10),
            Text('Phone Number: $phoneNumber'),
            SizedBox(height: 10),
            Text('Location: $location'),
            SizedBox(height: 20),
            Text('Cash: \$${totalPrice.toStringAsFixed(2)}'),
            SizedBox(height: 20),
            Center(
              child: IconButton(
                icon: Icon(Icons.home,
                    color: const Color.fromARGB(255, 118, 203, 121), size: 30),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
