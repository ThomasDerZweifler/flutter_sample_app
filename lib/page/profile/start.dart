import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/page/profile/post_list.dart';
import 'package:flutter_sample_app/page/profile/profile_header.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final List<Post> _items = List<Post>.generate(
      20, (int index) => Post("title $index", "summary $index"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: SizedBox(
          // set the height property to take the screen width
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileHeader(
                imageUrl: 'assets/me.jpeg',
                name: 'ThoFu',
                bio: 'App developer',
              ),
              Expanded(
                child: PostList(posts: _items),
              ),
            ],
          ),
        ));
  }
}
