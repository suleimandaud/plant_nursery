import 'package:flutter/material.dart';
import 'package:plant_nursery/models/product.dart';
import 'order_detail_screen.dart';

class UserInfoScreen extends StatelessWidget {
  final List<Product> orderItems;

  UserInfoScreen({required this.orderItems});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  double calculateTotalPrice(List<Product> items) {
    double totalPrice = 0.0;
    for (Product product in items) {
      totalPrice += product.price;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = calculateTotalPrice(orderItems);

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text('User Info'),
        backgroundColor: Color.fromARGB(255, 118, 202, 119),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (!value.startsWith('61')) {
                    return 'phone numbe must start with "61" (e.g., 61XXXXXXX)';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration:
                    InputDecoration(labelText: 'Location(District/Region)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your location (district/region)';
                  } else if (!value.contains('/')) {
                    return 'Location must contain "/" (e.g., District/Region)';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailScreen(
                          orderItems: orderItems,
                          customerName: _nameController.text,
                          phoneNumber: _phoneController.text,
                          location: _locationController.text,
                          totalPrice: totalPrice,
                        ),
                      ),
                    );
                  }
                },
                child: Text('Confirm Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
