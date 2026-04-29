import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../model/models.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final ApiService api = ApiService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Red Social - Posts")),
      body: FutureBuilder<List<Post>>(
        future: api.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, i) {
              final post = snapshot.data![i];
              return ListTile(
                title: Text(
                  post.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(post.body, maxLines: 2),
                trailing: Icon(Icons.arrow_forward_ios),
                // Dentro del ListView.builder de home_screen.dart
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(post: post),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
