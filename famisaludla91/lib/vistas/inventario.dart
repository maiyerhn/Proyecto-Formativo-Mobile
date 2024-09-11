import 'package:famisaludla91/main.dart';
import 'package:famisaludla91/vistas/productos.dart';
import 'package:famisaludla91/vistas/usuarios.dart';
import 'package:flutter/material.dart';

class Inventario extends StatelessWidget {
  const Inventario({super.key});

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
      drawer: const AppDrawer(),
      body: const SingleChildScrollView( // Permite el desplazamiento si el contenido es demasiado largo
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Asegura que el contenido ocupe todo el ancho
            children: [
              // Información del Administrador
              AdministratorInfo(),
              SizedBox(height: 10),

              // Pedidos en Espera
              PendingOrders(),
              SizedBox(height: 10),

              // Productos Más y Menos Vendidos
              TopProducts(),
            ],
          ),
        ),
      ),
    );
  }
}

class AdministratorInfo extends StatelessWidget {
  // Placeholder texts; these will be replaced with actual data from the database
  final String name = ''; // Replace with actual name
  final String email = ''; // Replace with actual email
  final String phone = ''; // Replace with actual phone number
  final String role = '';

  const AdministratorInfo({super.key}); // Replace with actual role

  @override
  Widget build(BuildContext context) {
    final textStyle = DefaultTextStyle.of(context).style.copyWith(
      fontSize: 16,
      color: Colors.black87,
    );

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Información del Administrador',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(context, Icons.person, 'Nombre:', name, textStyle),
            const Divider(),
            _buildInfoRow(context, Icons.email, 'Email:', email, textStyle),
            const Divider(),
            _buildInfoRow(context, Icons.phone, 'Teléfono:', phone, textStyle),
            const Divider(),
            _buildInfoRow(context, Icons.work, 'Rol:', role, textStyle),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value, TextStyle textStyle) {
    return Row(
      children: <Widget>[
        Icon(icon, color: Colors.blueGrey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: textStyle,
              children: <TextSpan>[
                TextSpan(
                  text: '$label ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: value.isEmpty ? 'Sin información' : value,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PendingOrders extends StatefulWidget {
  const PendingOrders({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Pedidos En Espera',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Resumen de los Pedidos que se encuentran en Espera:',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            // DataTable widget
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black12), // Lighter border color
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 24,
                  dataRowHeight: 50, // Default row height
                  headingRowHeight: 50, // Default heading row height
                  headingRowColor: WidgetStateColor.resolveWith(
                    (states) => Colors.white, // White background for heading rows
                  ),
                  dataRowColor: WidgetStateColor.resolveWith(
                    (states) => Colors.white, // White background for data rows
                  ),
                  columns: [
                    DataColumn(
                      label: Container(
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          'Correo',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          'Estado',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          'Fecha y Hora',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          'Monto',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                  rows: const [], // No rows initially
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopProducts extends StatelessWidget {
  const TopProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '5 Productos Más y Menos Vendidos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            const SizedBox(height: 16),
            _buildProductSection('Más Vendidos', []),
            const SizedBox(height: 16),
            _buildProductSection('Menos Vendidos', []),
          ],
        ),
      ),
    );
  }

  Widget _buildProductSection(String title, List<String> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[700],
          ),
        ),
        const SizedBox(height: 8),
        products.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('No hay productos disponibles', style: TextStyle(color: Colors.grey[600])),
              )
            : Column(
                children: products.map((product) => _buildProductRow(product)).toList(),
              ),
      ],
    );
  }

  Widget _buildProductRow(String product) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100], // Color de fondo gris claro
          borderRadius: BorderRadius.circular(8), // Bordes redondeados
          border: Border.all(color: Colors.grey[300]!), // Borde gris claro
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            Icon(Icons.trending_up, color: Colors.green[700]), // Icono representativo
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Nombre del Producto - Cantidad', // Texto de ejemplo
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Inicio()));
            },
          ),
        ],
      ),
    );
  }
}
