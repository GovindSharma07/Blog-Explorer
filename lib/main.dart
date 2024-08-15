import 'package:flutter/material.dart';

import 'pages/blog_list/ui/blog_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Blog Explorer",
      theme: ThemeData.dark(useMaterial3: false),
      home:  BlogListScreen(),
    );
  }
}
