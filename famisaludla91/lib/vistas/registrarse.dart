import 'package:famisaludla91/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  bool _isChecked = false;
  bool _isObscurePassword = true;

  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Registrarse')),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            const Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.black12,
                child: Icon(
                  Icons.person_add,
                  size: 50,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildTextField(label: 'Nombre', hintText: 'Ingrese nombres', controller: nombreController),
            _buildTextField(label: 'Apellido', hintText: 'Ingrese apellidos', controller: apellidoController),
            _buildNumberField(label: 'Teléfono', hintText: 'Ingrese Teléfono', controller: telefonoController),
            _buildTextField(label: 'Dirección', hintText: 'Ingrese Dirección', controller: direccionController),
            _buildEmailField(label: 'Usuario (E-mail)', hintText: 'Ingrese Usuario', controller: emailController),
            _buildPasswordField(label: 'Contraseña', hintText: 'Ingrese Contraseña', controller: passwordController),
            _buildTextField(label: 'Confirmar Contraseña', hintText: 'Confirmar Contraseña', obscureText: true, controller: confirmPasswordController),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: RichText(
                    text: const TextSpan(
                      text: 'I agree to the ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Terms of Services',
                          style: TextStyle(color: Colors.blue),
                        ),
                        TextSpan(
                          text: ' and ',
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(color: Colors.blue),
                        ),
                        TextSpan(
                          text: '.',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isChecked ? () => _register(context) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Registrarse'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Inicio()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Iniciar sesión'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    bool obscureText = false,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildEmailField({
    required String label,
    required String hintText,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (!emailRegExp.hasMatch(value)) {
          }
        },
      ),
    );
  }

  Widget _buildNumberField({
    required String label,
    required String hintText,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        maxLength: 10,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: const OutlineInputBorder(),
          counterText: '', 
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required String hintText,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        obscureText: _isObscurePassword,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              _isObscurePassword ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isObscurePassword = !_isObscurePassword;
              });
            },
          ),
        ),
      ),
    );
  }

  Future<void> _register(BuildContext context) async {
  final String nombre = nombreController.text;
  final String apellido = apellidoController.text;
  final String telefono = telefonoController.text;
  final String direccion = direccionController.text;
  final String email = emailController.text.trim().toLowerCase();
  final String password = passwordController.text;
  final String confirmPassword = confirmPasswordController.text;

  if (nombre.isEmpty ||
      apellido.isEmpty ||
      telefono.isEmpty ||
      direccion.isEmpty ||
      email.isEmpty ||
      password.isEmpty ||
      confirmPassword.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Todos los campos deben ser llenados')),
    );
    return;
  }

  if (password != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Las contraseñas no coinciden')),
    );
    return;
  }

  if (!emailRegExp.hasMatch(email)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('El correo electrónico no es válido')),
    );
    return;
  }

  if (telefono.length != 10) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('El teléfono debe tener 10 dígitos')),
    );
    return;
  }

  final RegExp passwordRegExp = RegExp(
    r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  if (!passwordRegExp.hasMatch(password)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('La contraseña debe tener al menos 8 caracteres, una mayúscula y un número')),
    );
    return;
  }

  try {
    final url = Uri.parse('https://ba3e-45-238-146-4.ngrok-free.app/signup');
    final response = await http.post(
      url,
      body: jsonEncode({
        'user': {
          'name': nombre,
          'last_name': apellido,
          'phone': telefono,
          'address': direccion,
          'email': email,
          'password': password,
          'role': 'CLIENTE',
        },
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) { 
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Inicio()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
      );
    } else {
      final error = jsonDecode(response.body)['errors'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error de conexión: $e')),
    );
  }
}


}
