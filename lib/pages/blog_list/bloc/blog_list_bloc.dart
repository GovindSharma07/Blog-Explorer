import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../constants/blog_api_key.dart';
import '../../../models/blog_model.dart';

part 'blog_list_event.dart';

part 'blog_list_state.dart';

class BlogListBloc extends Bloc<BlogListEvent, BlogListState> {
  BlogListBloc() : super(BlogListInitial()) {
    on<BlogListFetchDataEvent>(_blogListFetchData);
  }

  Future<FutureOr<void>> _blogListFetchData(
      BlogListFetchDataEvent event, Emitter<BlogListState> emit) async {
    emit(BlogListLoadingState());
    final String url = apiUrl;
    final String adminSecret = adminSecretKey;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });
      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          emit(BlogListEmptyState());
        } else {

          var data = jsonDecode(response.body);
          List<BlogModel> list = [];
          for(var i in data["blogs"]){
            list.add(BlogModel.fromJson(i));
          }
          emit(BlogListSuccessState(list));
        }
      }
    } catch (e) {
      emit(BlogListErrorState(e.toString()));
    }
  }
}
