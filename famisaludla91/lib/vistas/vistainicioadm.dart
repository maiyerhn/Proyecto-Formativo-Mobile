import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:famisaludla91/main.dart';
import 'package:famisaludla91/vistas/inventario.dart';
import 'package:famisaludla91/vistas/productos.dart';
import 'package:famisaludla91/vistas/usuarios.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Inicioad extends StatelessWidget {
  const Inicioad({super.key});
    Future<void> _logout(BuildContext context) async {
  try {
    final url = Uri.parse('https://c7fc-45-238-146-4.ngrok-free.app/logout');
    final String? token = await _getToken(); 

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se encontró el token de autenticación.')),
      );
      return;
    }

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Eliminar el token almacenado
      await _removeToken();

      // Navegar a la pantalla de inicio o pantalla de inicio de sesión
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Inicio()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al cerrar sesión.')),
      );
    }
  } on SocketException {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error de conexión. Verifica tu conexión a internet.')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ocurrió un error: $e')),
    );
  }
}

Future<void> _removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('jwt_token');
}

Future<String?> _getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt_token');
}

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
              // muestra el model de abajo
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return _buildModalDrawer(context);
                },
              );
            },
          ),
        ],
      ),
      drawer: _buildMainDrawer(context),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
        ],

        selectedItemColor: Colors.blue,
        backgroundColor: Colors.white,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Inicioad()),
              );
              break;
            /*case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Buscar()),
              );
              break;
              */
          }
        },
      ),
    );
  }

  // modal menu
  Widget _buildMainDrawer(BuildContext context) {
    return Drawer(
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
              Navigator.pop(context, MaterialPageRoute(builder: (context) => const Inventario()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.production_quantity_limits, color: Colors.blue),
            title: const Text('Productos'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Productos()));
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Usuarios()));
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
              _logout(context); 
            },
          ),
        ],
      ),
    );
  }

  // Modal 
  Widget _buildModalDrawer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle, color: Colors.blue),
            title: const Text('Usuario'),
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
    );
  }
}
