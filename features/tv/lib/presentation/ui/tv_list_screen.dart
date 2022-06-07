import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:tv/presentation/ui/on_air_tab_screen.dart';
import 'package:tv/presentation/ui/popular_tab_screen.dart';

class TvScreen extends StatefulWidget {
  const TvScreen({Key? key}) : super(key: key);

  @override
  _TvScreenState createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryWhite,
      appBar: CustomAppBar(
        controller: _tabController,
        label: Strings.television,
        isCenterTitle: true,
        tabBarTitle: const [
          Strings.onTheAir,
          Strings.popular,
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          OnAirTabScreen(),
          PopularTabScreen(),
        ],
      ),
    );
  }
}
