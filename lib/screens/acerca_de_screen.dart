import 'package:flutter/material.dart';

class AcercaDeScreen extends StatelessWidget {
  final List<Map<String, String>> desarrolladores = [
    {
      "nombre": "Misael Encarnacion Javier",
      "matricula": "2022-1994",
      "foto": "https://instagram.fsdq1-1.fna.fbcdn.net/v/t51.2885-19/366178648_263529866462278_2611381762331397083_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fsdq1-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=ZOlQ64Xx_yYQ7kNvgGKxCcS&_nc_gid=9b783a1084bf4d9dbd4b1309e72e17cd&edm=ALGbJPMBAAAA&ccb=7-5&oh=00_AYCEIjmV71hVTnKQ71LUjWjh2QsjxOcekS4OpgZvddrbqg&oe=67513C95&_nc_sid=7d3ac5", // URL de la foto
      "bio":
          "Estudiante de Ingeniería en Software apasionado por el desarrollo de aplicaciones móviles y la inteligencia artificial.",
    },
    
    {
      "nombre": "Alan Ricardo Bernabe De La Cruz",
      "matricula": "2022-0891",
      "foto": "https://scontent.fhex4-2.fna.fbcdn.net/v/t1.6435-9/58675166_1001160483411829_8694823049192538112_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=IT2Lcln_eCkQ7kNvgFZFgbj&_nc_zt=23&_nc_ht=scontent.fhex4-2.fna&_nc_gid=A-8aa3Bh0LhrGz1SDi1GN2e&oh=00_AYDQ8MqX9h3WCj5Y9yiIfE4TKxlpe7KzZCn65GxR9adMVg&oe=6772FD82", // URL de la foto
      "bio":
          "Entusiasta del desarrollo web y móvil con interés en soluciones basadas en la nube y la automatización.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de los Desarrolladores'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: desarrolladores.length,
          itemBuilder: (context, index) {
            final desarrollador = desarrolladores[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Foto del desarrollador
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        desarrollador["foto"]!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 20),
                    // Información del desarrollador
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            desarrollador["nombre"]!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Matrícula: ${desarrollador["matricula"]!}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            desarrollador["bio"]!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
