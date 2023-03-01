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
  int _selectedIndex = 0;
  final User user;
  NaviBar? naviBar;

  @override
  void initState() {
    naviBar = NaviBar(targetview: (index) {
      setState(() {
        _selectedIndex = index;
      });
    });
    super.initState();
  }

  final List<Widget> _pages = [
    //SafeArea(minimum: const EdgeInsets.all(2), child: _HomePage()),
    SafeArea(minimum: const EdgeInsets.all(2), child: _SettingsPage()),
    SafeArea(minimum: const EdgeInsets.all(2), child: PostPage())
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
                style: GoogleFonts.arima(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.white,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 2,
      ),
      backgroundColor: Color.fromARGB(255, 236, 251, 252),
      body: _pages[_selectedIndex],
      bottomNavigationBar: naviBar,
      /*bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: GNav(
                selectedIndex: _selectedIndex,
                onTabChange: _navigateBottomBar,
                backgroundColor: Colors.blue,
                color: Color.fromARGB(150, 255, 255, 255),
                activeColor: Colors.white,
                gap: 10,
                tabBackgroundColor: Color.fromARGB(120, 255, 255, 255),
                padding: EdgeInsets.all(10),
                tabs: [
                  GButton(
                    icon: Icons.image,
                    text: 'Post',
                  ),
                  GButton(
                    icon: Icons.logout,
                    text: 'Logout',
                  )
                ]),
          ),
        ),
      ),*/
    );
  }

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

/*class _PostPage extends StatelessWidget {
  const _PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final postRepo = new PostRepository();
        return PostBloc(postRepository: postRepo)
          ..add(PostFetched());
      },
      child: const PostList(),
    );
  }
}*/

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

class NaviBar extends StatefulWidget {
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
}
