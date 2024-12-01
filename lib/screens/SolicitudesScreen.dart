import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SolicitudesScreen extends StatefulWidget {
  @override
  _SolicitudesScreenState createState() => _SolicitudesScreenState();
}

class _SolicitudesScreenState extends State<SolicitudesScreen> {
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  bool _isSubmitting = false;
  String _message = '';

  Future<void> _crearSolicitud(String tipo, String descripcion) async {
    final url = Uri.parse('https://uasdapi.ia3x.com/crear_solicitud');
    final headers = {
      'accept': '*/*',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEwIiwibmJmIjoxNzMyOTc0NzIzLCJleHAiOjE3MzI5NzgzMjMsImlhdCI6MTczMjk3NDcyM30.onw3Udn6_3N4EdgHO7Bm35Gb9-NSypMD17DeUn58OpU',
      'Content-Type': 'application/json',
    };
    final body = json.encode({
      'tipo': tipo,
      'descripcion': descripcion,
    });

    setState(() {
      _isSubmitting = true;
      _message = '';
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          _message = 'Solicitud enviada exitosamente.';
          _isSubmitting = false;
        });
      } else {
        setState(() {
          _message = 'Error al enviar la solicitud: ${response.reasonPhrase}';
          _isSubmitting = false;
        });
      }
    } catch (error) {
      setState(() {
        _message = 'Error de conexión: $error';
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Solicitud'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tipoController,
              decoration: InputDecoration(labelText: 'Tipo de Solicitud'),
            ),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(labelText: 'Descripción'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            if (_isSubmitting)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () {
                  final tipo = _tipoController.text.trim();
                  final descripcion = _descripcionController.text.trim();
                  if (tipo.isNotEmpty && descripcion.isNotEmpty) {
                    _crearSolicitud(tipo, descripcion);
                  } else {
                    setState(() {
                      _message = 'Por favor, completa todos los campos.';
                    });
                  }
                },
                child: Text('Enviar Solicitud'),
              ),
            SizedBox(height: 20),
            if (_message.isNotEmpty)
              Text(
                _message,
                style: TextStyle(
                  color: _message.startsWith('Error') ? Colors.red : Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
