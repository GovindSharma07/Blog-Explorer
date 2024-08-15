part of 'blog_favorite_bloc.dart';

@immutable
sealed class BlogFavoriteEvent {}

final class BlogFavoriteFetchDataEvent extends BlogFavoriteEvent{}
