part of 'blog_favorite_bloc.dart';

@immutable
sealed class BlogFavoriteState {}

final class BlogFavoriteInitial extends BlogFavoriteState {}

final class BlogFavoriteSuccessState extends BlogFavoriteState {
  final List<BlogModel> blogModelList;

  BlogFavoriteSuccessState(this.blogModelList);
}

final class BlogFavoriteLoadingState extends BlogFavoriteState{}

final class BlogFavoriteEmptyState extends BlogFavoriteState{}
