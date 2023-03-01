part of 'post_bloc.dart';

enum PostStatus { initial, success, failure }

class PostState extends Equatable {
  const PostState({
    this.status = PostStatus.initial,
    this.post = const <Post>[],
    this.hasReachedMax = false,
  });

  final PostStatus status;
  final List<Post> post;
  final bool hasReachedMax;

  PostState copyWith({
    PostStatus? status,
    List<Post>? post,
    bool? hasReachedMax,
  }) {
    return PostState(
      status: status ?? this.status,
      post: this.post,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${post.length} }''';
  }

  @override
  List<Object> get props => [status, post, hasReachedMax];
}
