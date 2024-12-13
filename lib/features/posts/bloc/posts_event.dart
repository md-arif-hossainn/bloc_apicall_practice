abstract class PostsEvent {}

class PostsInitialFetchEvent extends PostsEvent {}

class PostAddEvent extends PostsEvent{
  final String title;
  final String body;
  final String userId;

  PostAddEvent({required this.title, required this.body, required this.userId});
}