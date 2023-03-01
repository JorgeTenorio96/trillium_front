import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../data/repositories/post_repository.dart';
import '../../models/post.dart';
part 'post_event.dart';
part 'post_state.dart';

const throttleDuration = Duration(milliseconds: 100);
int page = -1;
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({required this.postRepository}) : super(const PostState()) {
    on<PostFetched>(
      _onPostsFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onPostsFetched(PostFetched event, Emitter<PostState> emitter) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        page = 0;
        final response = await postRepository.fetchPosts(page);
        //final post = response;
        return emitter(state.copyWith(
          status: PostStatus.success,
          post: response.content,
          hasReachedMax: response.totalPages! - 1 <= page,
        ));
      }
      page += 1;
      final response = await postRepository.fetchPosts(page);
      final favPosts = response;

      emitter(state.copyWith(status: PostStatus.success, post: List.of(state.post)..addAll(favPosts.content!), hasReachedMax: response.totalPages! - 1 <= page));
    } catch (_) {
      emitter(state.copyWith(status: PostStatus.failure));
    }
  }
}
