import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart';


 // Asegúrate de que esta pantalla exista con este nombre
 // Importa la pantalla de deudas
 // Importa la pantalla de solicitudes

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool _isLoading = true;
  List<Map<String, String>> _news = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    final url = Uri.parse('https://uasd.edu.do/periodico/');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          _news = _parseNews(response.body);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage =
              'Error al obtener noticias (Código: ${response.statusCode})';
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Error al conectar con el servidor';
        _isLoading = false;
      });
    }
  }

  List<Map<String, String>> _parseNews(String htmlContent) {
    final document = parse(htmlContent);
    final articles = document.getElementsByClassName('card');

    return articles.map((article) {
      final titleElement = article.querySelector('.card-title');
      final descriptionElement = article.querySelector('.card-text');
      final imageElement = article.querySelector('img');

      return {
        'title': titleElement?.text ?? 'Sin título',
        'description': descriptionElement?.text ?? 'Sin descripción',
        'image': imageElement?.attributes['src'] ?? '',
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias'),
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
              ))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _news.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: _news[index]['image']!.isNotEmpty
                            ? Image.network(
                                _news[index]['image']!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : null,
                        title: Text(_news[index]['title']!),
                        subtitle: Text(_news[index]['description']!),
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
