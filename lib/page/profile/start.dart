import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/page/profile/post_list.dart';
import 'package:flutter_sample_app/page/profile/profile_header.dart';

import 'image_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final List<Post> _items = List<Post>.generate(
      20, (int index) => Post("title $index", "summary $index"));

  ImageProvider imageProvider = FileImage(File(""));

  Future getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      //File file = File(result.files.single.path!);
      setState(() {
        //imageProvider = FileImage(file);
        showDialog(context: context, builder: (_) => ImageDialog(result.files.single.path!));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: SizedBox(
          // set the height property to take the screen width
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    )),
              ),

              ProfileHeader(
                imageUrl: 'assets/me.jpeg',
                name: 'ThoFu',
                bio: 'App developer'
              ),
              Expanded(
                child: PostList(posts: _items),
              ),
            ],
          ),
        ));
  }
}

