import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_nursery/models/product.dart';

class AddProductScreen extends StatefulWidget {
  final String categoryName;
  final Function(Product) onAddProduct;

  AddProductScreen({required this.categoryName, required this.onAddProduct});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _saveProduct() {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    final newProduct = Product(
      id: DateTime.now().toString(), // Generate a unique ID
      name: _nameController.text,
      imageUrl: _image!.path, // Store image path
      description: _descriptionController.text,
      price: double.parse(_priceController.text),
      Height: _heightController.text.isNotEmpty ? _heightController.text : null,
      age: _ageController.text.isNotEmpty ? _ageController.text : null,
    );

    widget.onAddProduct(newProduct);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text('Add New Product'),
        backgroundColor: Color.fromARGB(255, 118, 202, 119),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            if (widget.categoryName == 'Saplings') ...[
              TextField(
                controller: _heightController,
                decoration: InputDecoration(labelText: 'Height'),
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
              ),
            ],
            SizedBox(height: 20),
            _image == null ? Text('No image selected.') : Image.file(_image!),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Image'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromARGB(255, 118, 202, 119), // Button color
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProduct,
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromARGB(255, 118, 202, 119), // Button color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
