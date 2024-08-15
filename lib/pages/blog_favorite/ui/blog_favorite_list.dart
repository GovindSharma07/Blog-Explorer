import 'package:blog_explorer/pages/blog_favorite/bloc/blog_favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../component/blog_box.dart';
import '../../../constants/color.dart';
import '../../../models/blog_model.dart';

class BlogFavoriteScreen extends StatelessWidget {
  BlogFavoriteScreen({super.key});

  final BlogFavoriteBloc favoriteBloc = BlogFavoriteBloc();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Blogs"),
        centerTitle: true,
      ),
      body: Container(
        height: size.height,
        decoration: BoxDecoration(gradient: bgGradient),
        child: RefreshIndicator(
          onRefresh: () async {
            favoriteBloc.add(BlogFavoriteFetchDataEvent());
          },
          child: BlocBuilder(
            bloc: favoriteBloc,
            builder: (context, state) {
              if (state is BlogFavoriteInitial) {
                favoriteBloc.add(BlogFavoriteFetchDataEvent());
                return SizedBox(
                  height: size.height,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is BlogFavoriteLoadingState) {
                return SizedBox(
                  height: size.height,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is BlogFavoriteEmptyState) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Image.asset(
                    "assets/images/nothing_found.png",
                    fit: BoxFit.fill,
                  ),
                );
              } else if (state is BlogFavoriteSuccessState) {
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
