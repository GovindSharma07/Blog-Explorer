import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_explorer/database/database_helper.dart';
import 'package:meta/meta.dart';

import '../../../models/blog_model.dart';

part 'blog_favorite_event.dart';
part 'blog_favorite_state.dart';

class BlogFavoriteBloc extends Bloc<BlogFavoriteEvent, BlogFavoriteState> {
  BlogFavoriteBloc() : super(BlogFavoriteInitial()) {
    on<BlogFavoriteFetchDataEvent>(_blogFavoriteFetchData);
  }

  Future<FutureOr<void>> _blogFavoriteFetchData(
      BlogFavoriteFetchDataEvent event, Emitter<BlogFavoriteState> emit) async {
    emit(BlogFavoriteLoadingState());
    final db = DatabaseHelper.instance;
    final data = await db.getAllFavoriteBlogs();
    if (data.isEmpty) {
      emit(BlogFavoriteEmptyState());
    } else {
      List<BlogModel> list = [];
      for (var i in data) {
        list.add(BlogModel.fromJson(i));
      }
      emit(BlogFavoriteSuccessState(list));
    }
  }
}
