part of 'blog_list_bloc.dart';

@immutable
sealed class BlogListEvent {}

final class BlogListFetchDataEvent extends BlogListEvent {}
