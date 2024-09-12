class Producto {
  final int id;
  final String name;
  final String description;
  final int price;
  final String imageUrl; 
  final int stock;

  Producto({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl, 
    required this.stock,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['image_url'] ?? '', 
      stock: json['stock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl, 
      'stock': stock,
    };
  }
}
