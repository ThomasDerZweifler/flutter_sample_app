import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Post {
  final String title;
  final String summary;

  const Post(this.title, this.summary);
}

class PostList extends StatelessWidget {
  final List posts;

  const PostList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.article),
          title: Text(posts[index].title),
          subtitle: Text(posts[index].summary),
        );
      },
    );
  }
}
