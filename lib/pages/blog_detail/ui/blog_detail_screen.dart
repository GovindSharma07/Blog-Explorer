import 'package:blog_explorer/component/hero_network_image.dart';
import 'package:blog_explorer/constants/blog_content.dart';
import 'package:blog_explorer/constants/color.dart';
import 'package:blog_explorer/database/database_helper.dart';
import 'package:blog_explorer/models/blog_model.dart';
import 'package:flutter/material.dart';

class BlogDetailScreen extends StatelessWidget {
  const BlogDetailScreen({super.key, required this.blogModel});

  final BlogModel blogModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final db = DatabaseHelper.instance;
          var i = await db.insertBlog(blogModel);
          if (i == -1) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Blog already added successfully")));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Blog added successfully")));
          }
        },
        child: const Icon(Icons.add_task),
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          decoration: BoxDecoration(gradient: bgGradient),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  blogModel.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: heroNetworkImage(blogModel, size.width)),
                const Text(
                  longContent,
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
