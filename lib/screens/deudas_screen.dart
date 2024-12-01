import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeudasScreen extends StatefulWidget {
  @override
  _DeudasScreenState createState() => _DeudasScreenState();
}

class _DeudasScreenState extends State<DeudasScreen> {
  bool _isLoading = true;
  String _errorMessage = '';
  Map<String, dynamic>? _deuda;

  @override
  void initState() {
    super.initState();
    _fetchDeuda();
  }

  Future<void> _fetchDeuda() async {
    final url = Uri.parse('https://uasdapi.ia3x.com/deudas');
    try {
      final response = await http.get(
        url,
        headers: {
          'accept': '*/*',
          'Authorization':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEwIiwibmJmIjoxNzMzMDkzODU4LCJleHAiOjE3MzMwOTc0NTgsImlhdCI6MTczMzA5Mzg1OH0.gGyg4IriDC6B7vRQw35hUtilrIj1qUaX9S-S-NDX1m0',
        },
      );

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        setState(() {
          _deuda = decodedData;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage =
              'Error al obtener deuda (Código: ${response.statusCode})';
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage =
            'Error al conectar con el servidor. Por favor, inténtelo más tarde.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deudas Pendientes'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _errorMessage.isNotEmpty
                ? Center(
                    child: Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  )
                : _deuda != null
                    ? _buildDeudaCard()
                    : Center(
                        child: Text(
                          'No hay deudas registradas.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
      ),
    );
  }

  Widget _buildDeudaCard() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Deuda Actual',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'ID Usuario: ${_deuda?['usuarioId'] ?? 'No disponible'}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Monto: \$${_deuda?['monto'] ?? '0.00'}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Estado: ${_deuda?['pagada'] == true ? 'Pagada' : 'Pendiente'}',
              style: TextStyle(
                fontSize: 16,
                color: _deuda?['pagada'] == true ? Colors.green : Colors.red,
              ),
            ),
            Text(
              'Última Actualización: ${_deuda?['fechaActualizacion'] ?? 'No disponible'}',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _realizarPago();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('Pagar Ahora'),
            ),
          ],
        ),
      ),
    );
  }

  void _realizarPago() {
    print('Redirigir a la página de pago...');
    // Aquí puedes implementar la lógica de redirección o pago.
  }
}
