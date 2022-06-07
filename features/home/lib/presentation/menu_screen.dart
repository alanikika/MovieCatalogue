import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:home/presentation/bloc/bloc.dart';
import 'package:movie/presentation/ui/movie_list_screen.dart';
import 'package:shared/shared.dart';
import 'package:tv/presentation/ui/tv_list_screen.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _bottomNavIndex = 0;

  @override
  void initState() {
    Modular.get<HomeBloc>().add(MovieStarted());
    super.initState();
  }

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.movie_creation),
      label: Modular.get<Strings>().movie,
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.tv),
      label: Modular.get<Strings>().tv,
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.person_pin),
      label: Modular.get<Strings>().profile,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {});
    _bottomNavIndex = index;
    Modular.get<HomeBloc>().add(PageTapped(index: index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is MoviePageLoaded) {
            return const MovieListScreen();
          } else if (state is TvPageLoaded) {
            return const TvScreen();
          } else if (state is ProfilePageLoaded) {
            // return ProfileScreen();
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
