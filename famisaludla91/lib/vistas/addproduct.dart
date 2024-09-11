import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  File? _image;
  bool _isUploading = false;

  final ImagePicker _picker = ImagePicker();
  
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) { 
        _image = File(pickedFile.path);
      }
    });
  }

Future<void> _saveProduct() async {
  if (_nameController.text.isEmpty || _descriptionController.text.isEmpty ||
      _priceController.text.isEmpty || _stockController.text.isEmpty) {
    print('Please fill in all fields.');
    return;
  }

  if (_image == null) {
    print('No image selected.');
    return;
  }

  setState(() {
    _isUploading = true;
  });

  var uri = Uri.parse('https://c7fc-45-238-146-4.ngrok-free.app/products');
  var request = http.MultipartRequest('POST', uri);

  request.fields['product[name]'] = _nameController.text;
  request.fields['product[description]'] = _descriptionController.text;
  request.fields['product[price]'] = _priceController.text;
  request.fields['product[stock]'] = _stockController.text;

  request.files.add(
    await http.MultipartFile.fromPath(
      'product[image]',
      _image!.path,
      contentType: MediaType('image', 'jpeg'),
    ),
  );

  var response = await request.send();

  setState(() {
    _isUploading = false;
  });

  if (response.statusCode == 201) {
    print('Product uploaded successfully');
    // Optionally, navigate back or show a success message
  } else {
    final responseBody = await response.stream.bytesToString();
    print('Failed to upload product: ${response.statusCode}, ${responseBody}');
    // Optionally, show an error message
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _stockController,
              decoration: InputDecoration(labelText: 'Stock'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!, height: 150),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Seleccionar Imagen'),
            ),
            SizedBox(height: 20),
            _isUploading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _saveProduct,
                    child: Text('Guardar'),
                  ),
          ],
        ),
      ),
    );
  }
}
