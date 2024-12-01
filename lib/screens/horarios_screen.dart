import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HorarioScreen extends StatefulWidget {
  @override
  _HorarioScreenState createState() => _HorarioScreenState();
}

class _HorarioScreenState extends State<HorarioScreen> {
  bool _isLoading = true;
  List<dynamic> _horarios = [];
  String _errorMessage = '';
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    _fetchHorarios();
  }

  Future<void> _fetchHorarios() async {
    final url = Uri.parse('https://uasdapi.ia3x.com/horarios/');
    try {
      final response = await http.get(
        url,
        headers: {
          'accept': '*/*',
          'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEwIiwibmJmIjoxNzMzMDk0OTE1LCJleHAiOjE3MzMwOTg1MTUsImlhdCI6MTczMzA5NDkxNX0.oMSPtwAWxfys18PvuK0EUwKg85L_ODvyWvSnWWY7S-g',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _horarios = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'No se pudieron cargar los horarios';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al conectar con el servidor';
        _isLoading = false;
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Horarios'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_isLoading)
              Center(child: CircularProgressIndicator())
            else if (_errorMessage.isNotEmpty)
              Center(child: Text(_errorMessage, style: TextStyle(color: Colors.red)))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _horarios.length,
                  itemBuilder: (context, index) {
                    final horario = _horarios[index];
                    final materia = horario['materia'];
                    final hora = horario['hora'];
                    final aula = horario['aula'];
                    final lat = horario['latitud'];
                    final lng = horario['longitud'];

                    return Card(
                      child: ListTile(
                        title: Text(materia ?? 'Sin materia'),
                        subtitle: Text('Hora: $hora\nAula: $aula'),
                        onTap: () {
                          _showMap(lat, lng);
                        },
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

  void _showMap(double lat, double lng) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ubicación del Aula'),
        content: Container(
          height: 250,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(lat, lng),
              zoom: 15.0,
            ),
            onMapCreated: _onMapCreated,
            markers: {
              Marker(
                markerId: MarkerId('aula'),
                position: LatLng(lat, lng),
                infoWindow: InfoWindow(title: 'Aula'),
              ),
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
