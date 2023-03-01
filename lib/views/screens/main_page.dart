import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_trillium/bloc/post/post.dart';
import 'package:flutter_trillium/data/repositories/post_repository.dart';
import 'package:flutter_trillium/views/screens/post_page.dart';

import 'package:flutter_trillium/views/widgets/custom_button_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../bloc/post/post_bloc.dart';

import '../../bloc/authentication/authentication_bloc.dart';

import '../../models/post.dart';
import '../../models/user.dart';

class MainPage extends StatefulWidget {
  final User user;

  const MainPage({super.key, required this.user});

  @override
  State<MainPage> createState() => _MainPageState(user);
}

class _MainPageState extends State<MainPage> {
  int indices = 0;
  final User user;

  final List<Widget> _pages = [
    _PostPage(),
    _SettingsPage(),
  ];

  _MainPageState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 50,
          title: ClipRRect(
            child: Container(
              width: 90,
              height: 40,
              child: Center(
                child: Text(
                  'Trillium',
                  style: GoogleFonts.arima(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.white, fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.blue,
          elevation: 2,
        ),
        backgroundColor: Color.fromARGB(255, 236, 251, 252),
        body: IndexedStack(
          index: indices,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black), label: 'Posts'),
              BottomNavigationBarItem(icon: Icon(Icons.list_alt_rounded, color: Colors.black), label: 'Logout'),
            ],
            currentIndex: indices,
            onTap: (int index) {
              setState(() {
                indices = index;
              });
            }));
  }
}

class _PostPage extends StatelessWidget {
  const _PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final postRepo = new PostRepository();
    return Scaffold(
        body: BlocProvider(
      create: (_) {
        return PostBloc(postRepository: postRepo)..add(PostFetched());
      },
      child: Main(),
    ));
  }
}

class _SettingsPage extends StatelessWidget {
  const _SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Center(
      child: CustomButton(
        height: 50,
        color: Colors.blue,
        textColor: Colors.white,
        text: 'Logout',
        onTap: () {
          authBloc.add(UserLoggedOutEvent());
        },
      ),
    );
  }
}

/*class NaviBar extends StatefulWidget {
  final Function targetview;
  const NaviBar({Key? key, required this.targetview}) : super(key: key);
  @override
  State<StatefulWidget> createState() => NaviBarState();
}

class NaviBarState extends State<NaviBar> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: index,
        onTap: (int i) {
          setState(() {
            index = i;
            widget.targetview(i);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          )
        ]);
  }
}*/
