import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:famisaludla91/models/user.dart';
import 'package:famisaludla91/main.dart';
import 'package:famisaludla91/vistas/inventario.dart';
import 'package:famisaludla91/vistas/productos.dart';

class Usuarios extends StatefulWidget {
  const Usuarios({super.key});

  @override
  _UsuariosState createState() => _UsuariosState();
}

class _UsuariosState extends State<Usuarios> {
  List<Usuario> usuarios = [];

  @override
  void initState() {
    super.initState();
    _loadUsuarios();
  }
Future<bool> _updateUser(Usuario usuario) async {
  final url = 'https://ba3e-45-238-146-4.ngrok-free.app/users/${usuario.id}';
  final response = await http.put(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode({
      'name': usuario.name,
      'last_name': usuario.lastName,
      'email': usuario.email,
      'phone': usuario.phone,
      'address': usuario.address,
      'role': usuario.role,
    }),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}


  void _loadUsuarios() async {
    final url = 'https://ba3e-45-238-146-4.ngrok-free.app/users';
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Decodifica el JSON
        final List<dynamic> jsonList = json.decode(response.body);

        final List<Usuario> loadedUsuarios = jsonList.map((json) => Usuario.fromJson(json)).toList();

        setState(() {
          usuarios = loadedUsuarios.take(20).toList();
        });
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error loading users: $e');
    }
  }

  void _showUserModal(Usuario usuario) {
  final _nameController = TextEditingController(text: usuario.name);
  final _lastNameController = TextEditingController(text: usuario.lastName);
  final _emailController = TextEditingController(text: usuario.email);
  final _phoneController = TextEditingController(text: usuario.phone);
  final _addressController = TextEditingController(text: usuario.address);
  final _roleController = TextEditingController(text: usuario.role);

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.blue),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Editar Usuario',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 48), // Espacio para el botón de atrás
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Correo'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Teléfono'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Dirección'),
            ),
            TextField(
              controller: _roleController,
              decoration: InputDecoration(labelText: 'Rol'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final updatedUser = Usuario(
                  id: usuario.id,
                  name: _nameController.text,
                  lastName: _lastNameController.text,
                  email: _emailController.text,
                  phone: _phoneController.text,
                  address: _addressController.text,
                  role: _roleController.text,
                );

                final success = await _updateUser(updatedUser);
                if (success) {
                  Navigator.pop(context);
                  _loadUsuarios(); 
                } else {

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error al actualizar el usuario'),
                    ),
                  );
                }
              },
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Usuarios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
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
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Inventario()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.production_quantity_limits, color: Colors.blue),
              title: const Text('Productos'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Productos()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart, color: Colors.blue),
              title: const Text('Pedidos'),
              onTap: () {
                // Acción para pedidos
              },
            ),
            ListTile(
              leading: const Icon(Icons.people, color: Colors.blue),
              title: const Text('Usuarios'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Usuarios()));
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Inicio()));
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          final usuario = usuarios[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  '${usuario.name} ${usuario.lastName}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  usuario.email,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        _showUserModal(usuario);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Acción para eliminar usuario
                      },
                    ),
                  ],
                ),
                onTap: () {
                  // Navegar a la pantalla de productos cuando se toca un usuario
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Productos()),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
