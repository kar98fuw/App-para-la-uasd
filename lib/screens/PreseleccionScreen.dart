import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PreseleccionMateriasScreen extends StatefulWidget {
  @override
  _PreseleccionMateriasScreenState createState() =>
      _PreseleccionMateriasScreenState();
}

class _PreseleccionMateriasScreenState
    extends State<PreseleccionMateriasScreen> {
  bool _isLoading = true;
  List<dynamic> _materias = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchMaterias();
  }

  Future<void> _fetchMaterias() async {
    final url = Uri.parse('https://uasdapi.ia3x.com/materias_disponibles');
    try {
      final response = await http.get(
        url,
        headers: {
          'accept': '*/*',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEwIiwibmJmIjoxNzMzMDk0OTE1LCJleHAiOjE3MzMwOTg1MTUsImlhdCI6MTczMzA5NDkxNX0.oMSPtwAWxfys18PvuK0EUwKg85L_ODvyWvSnWWY7S-g',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _materias = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage =
              'Error al cargar las materias (Código: ${response.statusCode})';
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Error al conectar con el servidor.';
        _isLoading = false;
      });
    }
  }

  Future<void> _preseleccionarMateria(String codigo) async {
    final url = Uri.parse('https://uasdapi.ia3x.com/preseleccionar_materia');
    try {
      final response = await http.post(
        url,
        headers: {
          'accept': '*/*',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEwIiwibmJmIjoxNzMzMDk0OTE1LCJleHAiOjE3MzMwOTg1MTUsImlhdCI6MTczMzA5NDkxNX0.oMSPtwAWxfys18PvuK0EUwKg85L_ODvyWvSnWWY7S-g',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'codigo': codigo}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Materia preseleccionada con éxito.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al preseleccionar materia.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al conectar con el servidor.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preselección de Materias'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_isLoading)
              Center(child: CircularProgressIndicator())
            else if (_errorMessage.isNotEmpty)
              Center(
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _materias.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(_materias[index]['nombre'] ??
                            'Materia sin nombre'),
                        subtitle: Text('Código: ${_materias[index]['codigo']}'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            _preseleccionarMateria(_materias[index]['codigo']);
                          },
                          child: Text('Seleccionar'),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
