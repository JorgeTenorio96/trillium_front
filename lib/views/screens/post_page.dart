import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_trillium/views/screens/post_detail_page.dart';

import '../../bloc/post/post_bloc.dart';
import '../../data/repositories/post_repository.dart';
import '../../models/post.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({Key? key, required this.idPost}) : super(key: key);
  final int idPost;

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool _isLiked = false;
  final _postRepository = PostRepository();
  final int idPost = 1;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _postRepository.postLike(widget.idPost);
          _isLiked = !_isLiked;
        });
      },
      child: Icon(
        _isLiked ? Icons.favorite : Icons.favorite_border,
        color: _isLiked ? Colors.red : null,
        size: 30,
      ),
    );
  }
}

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 1;
    return BlocProvider(
      create: (context) => PostBloc(PostRepository())..add(PostFetched()),
      child: Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onScroll() {
    if (_isBottom) context.read<PostBloc>().add(PostFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return index >= state.post.length
                ? const BottomLoader()
                : PostItem(post: state.post[index]);
          },
          itemCount:
              state.hasReachedMax ? state.post.length : state.post.length + 1,
          controller: _scrollController,
        );
      },
    );
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Padding(
      padding: EdgeInsets.only(top: 6, bottom: 6),
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    ));
  }
}

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
        child: GestureDetector(
      child: Container(
        height: 300,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  post.title!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            Center(
                child: Image(
              image: NetworkImage(post.image!),
              height: 180,
            )),
            LikeButton(
              idPost: int.parse('${post.id}'),
            ),
          ]),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        ),
      ),
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => PostDetail(post: post))),
    ));
  }
}
