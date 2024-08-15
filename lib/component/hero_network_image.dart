import 'package:blog_explorer/models/blog_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget heroNetworkImage(BlogModel blogModel, double width) {
  return Hero(
      tag: blogModel.id,
      child: CachedNetworkImage(
        imageUrl: blogModel.image_url,
        width: width,
        fit: BoxFit.fill,
        progressIndicatorBuilder: (context, url, progress) {
          return Center(
            child: CircularProgressIndicator(
              value: progress.progress,
            ),
          );
        },
        errorWidget: (context, url, error) =>
            Image.asset("assets/images/be.jpg"),
      ));
}
