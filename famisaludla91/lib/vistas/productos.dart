import 'package:famisaludla91/main.dart';
import 'package:famisaludla91/vistas/addproduct.dart';
import 'package:famisaludla91/vistas/inventario.dart';
import 'package:famisaludla91/vistas/usuarios.dart';

import 'package:flutter/material.dart';

class Productos extends StatelessWidget {
  const Productos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Center(child: Text('Famisalud la 91')),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Acción del perfil
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Thomas Marriaga'),
              accountEmail: Text('thomasmarriaga123@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Center(
                  child: Icon(
                    Icons.person,
                    size: 50.0,
                    color: Colors.blue,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.inventory, color: Colors.blue),
              title: const Text('Inventario'),
              onTap: () {
                Navigator.pop(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Inventario()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.production_quantity_limits,
                  color: Colors.blue),
              title: const Text('Productos'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Productos()));
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart, color: Colors.blue),
              title: const Text('Pedidos'),
              onTap: () {
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people, color: Colors.blue),
              title: const Text('Usuarios'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Usuarios()));
                //Navigator.pop(context);
              },
            ),
            const Divider(),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.blue),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.blue),
              title: const Text('Salir'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Inicio()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Acción de búsqueda
                  },
                  child: const Text('Buscar'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProductScreen()),
                    );
                  },
                  child: const Text('Agregar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Acción de filtrar por categoría
                  },
                  child: const Text('Categoría'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildProductItem(
                    context,
                    imageUrl: 'lib/imagenes/VitaminaC.jpg',
                    title: 'Paracetamol',
                    price: '36',
                    category: 'Analgésico',
                    stock: '100',
                    description:
                        'Analgésico y antipirético para aliviar el dolor y la fiebre.',
                  ),
                  _buildProductItem(
                    context,
                    imageUrl: 'lib/imagenes/VitaminaC.jpg',
                    title: 'Amoxicilina',
                    price: '50',
                    category: 'Antibiótico',
                    stock: '12',
                    description:
                        'Antibiótico utilizado para tratar infecciones bacterianas.',
                  ),
                  _buildProductItem(
                    context,
                    imageUrl: 'lib/imagenes/VitaminaC.jpg',
                    title: 'Ibuprofeno',
                    price: '37',
                    category: 'Antiinflamatorio',
                    stock: '200',
                    description:
                        'Medicamento utilizado para reducir la fiebre y el dolor.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(BuildContext context,
      {required String imageUrl,
      required String title,
      required String price,
      required String category,
      required String stock,
      required String description}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(imageUrl, width: 80, height: 80, fit: BoxFit.cover),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Precio: $price',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Categoría: $category',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Stock: $stock',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    // Acción de editar
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Acción de eliminar
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
