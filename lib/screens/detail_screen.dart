import 'package:flutter/material.dart';
import '../model/models.dart';
import '../services/api_service.dart';

class DetailScreen extends StatelessWidget {
  final Post post;
  final ApiService api = ApiService();

  DetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalle del Post")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Sección del Post
            Text(post.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(post.body, style: const TextStyle(fontSize: 16)),
            const Divider(height: 30),

            // 2. Sección del Autor (Usando FutureBuilder para el User)
            FutureBuilder<User>(
              future: api.getUser(post.userId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final user = snapshot.data!;
                  return Card(
                    color: Colors.blue.shade50,
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text("Autor: ${user.name}"),
                      subtitle: Text("Email: ${user.email}\nCiudad: ${user.city}"),
                    ),
                  );
                }
                return const LinearProgressIndicator();
              },
            ),
            
            const SizedBox(height: 20),
            const Text("Comentarios", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // 3. Sección de Comentarios
            FutureBuilder<List<Comment>>(
              future: api.getComments(post.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text("No hay comentarios.");
                }

                return ListView.builder(
                  shrinkWrap: true, // Importante para que funcione dentro de SingleChildScrollView
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final comment = snapshot.data![index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(comment.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(comment.email, style: const TextStyle(color: Colors.blue, fontSize: 12)),
                            const SizedBox(height: 4),
                            Text(comment.body),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
