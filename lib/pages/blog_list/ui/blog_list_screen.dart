import 'package:blog_explorer/component/blog_box.dart';
import 'package:blog_explorer/constants/color.dart';
import 'package:blog_explorer/pages/blog_favorite/ui/blog_favorite_list.dart';
import 'package:blog_explorer/pages/blog_list/bloc/blog_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/blog_model.dart';

class BlogListScreen extends StatelessWidget {
  BlogListScreen({super.key});

  final BlogListBloc blogListBloc = BlogListBloc();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog Explorer"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => BlogFavoriteScreen()));
        },
        child: const Icon(Icons.favorite),
      ),
      body: Container(
        height: size.height,
        decoration: BoxDecoration(gradient: bgGradient),
        child: RefreshIndicator(
          onRefresh: () async {
            blogListBloc.add(BlogListFetchDataEvent());
          },
          child: BlocBuilder(
            bloc: blogListBloc,
            builder: (context, state) {
              if (state is BlogListInitial) {
                blogListBloc.add(BlogListFetchDataEvent());
                return SizedBox(
                  height: size.height,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is BlogListLoadingState) {
                return SizedBox(
                  height: size.height,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is BlogListEmptyState) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Image.asset(
                    "assets/images/nothing_found.png",
                    fit: BoxFit.fill,
                  ),
                );
              } else if (state is BlogListErrorState) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Image.asset(
                    "assets/images/error.png",
                    fit: BoxFit.fill,
                  ),
                );
              } else if (state is BlogListSuccessState) {
                return _getList(state.blogModelList);
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _getList(List<BlogModel> blogModelList) {
    return ListView.builder(
      itemCount: blogModelList.length,
      itemBuilder: (context, index) {
      return BlogBox(blogModel: blogModelList[index]);
    },);
  }
}
