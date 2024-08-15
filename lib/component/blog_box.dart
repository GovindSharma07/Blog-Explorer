import 'package:blog_explorer/component/hero_network_image.dart';
import 'package:blog_explorer/constants/blog_content.dart';
import 'package:blog_explorer/constants/color.dart';
import 'package:blog_explorer/models/blog_model.dart';
import 'package:flutter/material.dart';

import '../pages/blog_detail/ui/blog_detail_screen.dart';

class BlogBox extends StatelessWidget {
  BlogBox({super.key, required this.blogModel});

  late Size size;

  final BlogModel blogModel;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlogDetailScreen(blogModel: blogModel)));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white70, width: 2.0),
            borderRadius: BorderRadius.circular(20),
            gradient: bgGradient,
            boxShadow: const [
              BoxShadow(color: Colors.white10, offset: Offset(2.0, 2.0))
            ]),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: heroNetworkImage(blogModel, size.width / 4)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blogModel.title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 3,
                  ),
                  const Text(
                    shortContent,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
