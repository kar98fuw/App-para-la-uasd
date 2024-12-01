import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TareasScreen extends StatefulWidget {
  @override
  _TareasScreenState createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _tareas = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchTareas();
  }

  Future<void> _fetchTareas() async {
    final url = Uri.parse('https://uasdapi.ia3x.com/tareas');
    final headers = {
      'accept': '*/*',
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEwIiwibmJmIjoxNzMzMDk0OTE1LCJleHAiOjE3MzMwOTg1MTUsImlhdCI6MTczMzA5NDkxNX0.oMSPtwAWxfys18PvuK0EUwKg85L_ODvyWvSnWWY7S-g',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        setState(() {
          _tareas = List<Map<String, dynamic>>.from(json.decode(response.body));
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Error al cargar tareas: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al conectar con el servidor.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Tareas'),
        backgroundColor: Colors.blue,
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
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: _tareas.length,
                    itemBuilder: (context, index) {
                      final tarea = _tareas[index];
                      return GestureDetector(
                        onTap: () => _mostrarDetallesTarea(tarea, context),
                        child: MouseRegion(
                          onEnter: (event) {},
                          onExit: (event) {},
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(color: Colors.blueAccent),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tarea['titulo'] ?? 'Sin título',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  tarea['fechaVencimiento'] ??
                                      'Sin fecha de vencimiento',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  tarea['descripcion'] ?? 'Sin descripción',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey[700],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  void _mostrarDetallesTarea(
      Map<String, dynamic> tarea, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(tarea['titulo'] ?? 'Sin título'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Fecha de vencimiento: ${tarea['fechaVencimiento'] ?? 'N/A'}'),
              SizedBox(height: 8.0),
              Text('Descripción:'),
              Text(tarea['descripcion'] ?? 'Sin descripción'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
