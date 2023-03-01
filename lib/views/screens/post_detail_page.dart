import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/post.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Detail'),
      ),
      body: Center(
          child: Column(
        children: [
          Text(
            post.title.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child:
                Image(image: NetworkImage(post.image.toString()), height: 200),
          ),
        ],
      )),
    );
  }
}
