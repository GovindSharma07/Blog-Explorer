part of 'blog_list_bloc.dart';

@immutable
sealed class BlogListState {}

final class BlogListInitial extends BlogListState {}

final class BlogListSuccessState extends BlogListState{

  final List<BlogModel> blogModelList;
  BlogListSuccessState(this.blogModelList);
}

final class BlogListLoadingState extends BlogListState{}

final class BlogListErrorState extends BlogListState{
  BlogListErrorState(String error);
}

final class BlogListEmptyState extends BlogListState{}

