import 'dart:async';

import 'package:bloc_apicall_practice/features/posts/bloc/posts_event.dart';
import 'package:bloc_apicall_practice/features/posts/bloc/posts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/post_data_model.dart';
import '../repos/posts_repo.dart';

class PostsBloc extends Bloc<PostsEvent,PostsState>{
  PostsBloc(): super(PostsInitial()){
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<PostAddEvent>(postAddEvent);
  }



  FutureOr<void> postsInitialFetchEvent(PostsInitialFetchEvent event, Emitter<PostsState> emit) async{
    emit(PostsFetchingLoadingState());
    List<PostDataUiModel> posts = await PostsRepo.fetchPosts();
    emit(PostFetchingSuccessfulState(posts: posts));

  }

  FutureOr<void> postAddEvent(PostAddEvent event, Emitter<PostsState> emit) async {
    bool success = await PostsRepo.addPost(event.title, event.body, event.userId);
    if (success) {
      emit(PostsAdditionSuccessState());
    } else {
      emit(PostsAdditionErrorState());
    }
  }
}