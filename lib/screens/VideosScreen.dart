import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class VideosScreen extends StatefulWidget {
  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  List<dynamic> videos = [];
  bool isLoading = true;
  String errorMessage = '';

  // Método para obtener los videos de la API
  Future<void> fetchVideos() async {
    final url = Uri.parse('https://uasdapi.ia3x.com/videos');
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
        final data = jsonDecode(response.body);

        if (data is List) {
          setState(() {
            videos = data;
            isLoading = false;
          });
        } else {
          throw Exception('Formato inesperado en la respuesta de la API');
        }
      } else {
        setState(() {
          errorMessage =
              'Error al cargar videos (Código: ${response.statusCode})';
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error al conectar con el servidor: $error';
        isLoading = false;
      });
    }
  }

  // Método para abrir un enlace en el navegador
  Future<void> openVideoLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir el enlace.')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos de la UASD'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  )
                : videos.isEmpty
                    ? Center(
                        child: Text(
                          'No hay videos disponibles.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          final video = videos[index];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            elevation: 5,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(10),
                              leading: Icon(
                                Icons.video_library,
                                size: 40,
                                color: Colors.blue,
                              ),
                              title: Text(
                                video['titulo'] ?? 'Sin título',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Publicado el: ${video['fechaPublicacion'] ?? 'Desconocido'}',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios, size: 20),
                              onTap: () {
                                final url = video['url'] ?? '';
                                if (url.isNotEmpty) {
                                  openVideoLink(url);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'El video no tiene un enlace válido.')),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
      ),
    );
  }
}
