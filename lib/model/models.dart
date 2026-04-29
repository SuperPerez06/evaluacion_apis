class Post {
  final int id;
  final String title;
  final String body;
  final int userId;

  Post({required this.id, required this.title, required this.body, required this.userId});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json['id'],
    title: json['title'],
    body: json['body'],
    userId: json['userId'],
  );
}

class User {
  final String name;
  final String email;
  final String city;

  User({required this.name, required this.email, required this.city});

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json['name'],
    email: json['email'],
    city: json['address']['city'],
  );
}

class Comment {
  final String name;
  final String email;
  final String body;

  Comment({required this.name, required this.email, required this.body});

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    name: json['name'],
    email: json['email'],
    body: json['body'],
  );
}