import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/EventosScreen.dart';
import 'package:flutter_application_1/screens/PreseleccionScreen.dart';
import 'package:flutter_application_1/screens/acerca_de_screen.dart';
import 'package:flutter_application_1/screens/deudas_screen.dart';
import 'package:flutter_application_1/screens/news_screen.dart';
import 'package:flutter_application_1/screens/horarios_screen.dart';
import 'package:flutter_application_1/screens/SolicitudesScreen.dart';
import 'package:flutter_application_1/screens/TareasScreen.dart';
import 'package:flutter_application_1/screens/VideosScreen.dart';
import 'package:flutter_application_1/screens/logout_screen.dart'; // Asegúrate de importar la pantalla de Logout

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú Principal'),
        backgroundColor: Colors.blue, // Color de la barra de navegación
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Botón para Deudas
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DeudasScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Color de fondo de Deudas
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.monetization_on, size: 30),
                        Text('Deudas'),
                      ],
                    ),
                  ),
                  // Botón para Preselección de Materias
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PreseleccionMateriasScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Color de fondo de Preselección
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.school, size: 30),
                        Text('Preselección'),
                      ],
                    ),
                  ),
                  // Botón para Noticias
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewsScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Color de fondo de Noticias
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.article, size: 30),
                        Text('Noticias'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Botón para Solicitudes
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SolicitudesScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple, // Color de fondo de Solicitudes
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.request_page, size: 30),
                        Text('Solicitudes'),
                      ],
                    ),
                  ),
                  // Botón para Horarios
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HorarioScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // Color de fondo de Horarios
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.schedule, size: 30),
                        Text('Horarios'),
                      ],
                    ),
                  ),
                  // Botón para Tareas
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TareasScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Color de fondo de Tareas
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.task, size: 30),
                        Text('Tareas'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Botón para Eventos
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventosScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lime.shade400, // Color de fondo de Eventos
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.event, size: 30),
                        Text('Eventos'),
                      ],
                    ),
                  ),
                  // Botón para Videos
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VideosScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo, // Color de fondo de Videos
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.video_library, size: 30),
                        Text('Videos'),
                      ],
                    ),
                  ),
                  // Botón para Acerca de
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AcercaDeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade400, // Color de fondo de Acerca de
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.info, size: 30),
                        Text('Acerca de'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Botón para Logout
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogoutScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400, // Color de fondo de Logout
                ),
                child: Column(
                  children: [
                    Icon(Icons.exit_to_app, size: 30),
                    Text('Cerrar Sesión'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
