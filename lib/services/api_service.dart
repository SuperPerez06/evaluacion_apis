import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/models.dart';

class ApiService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> getPosts() async {
    final res = await http.get(Uri.parse("$baseUrl/posts"));
    if (res.statusCode == 200) {
      List data = json.decode(res.body);
      return data.map((e) => Post.fromJson(e)).toList();
    }
    throw Exception("Fallo al cargar posts");
  }

  Future<User> getUser(int id) async {
    final res = await http.get(Uri.parse("$baseUrl/users/$id"));
    return User.fromJson(json.decode(res.body));
  }

  Future<List<Comment>> getComments(int postId) async {
    final res = await http.get(Uri.parse("$baseUrl/comments?postId=$postId"));
    List data = json.decode(res.body);
    return data.map((e) => Comment.fromJson(e)).toList();
  }
}