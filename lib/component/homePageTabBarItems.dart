import 'package:flutter/material.dart';

class HomePageTabBarItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight / 15,
      width: screenWidth,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            color: Colors.white,
            iconSize: 26,
            icon: Icon(Icons.gps_fixed),
          ),
          IconButton(
            onPressed: () {
              _showBottomSheet(context);
            },
            iconSize: 48,
            color: Colors.white,
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {},
            color: Colors.white,
            iconSize: 26,
            icon: Icon(Icons.list),
          ),
        ],
      ),
    );
  }
}

_showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.4,
        maxChildSize: 1.0,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBarTitle(scrollController),
                Expanded(
                  child: TabBarView(
                    children: [
                      _tabBarWeatherDataHours(),
                      _tabBarWeatherDataWeeks(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

ListView _tabBarWeatherDataWeeks() {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 20,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 84,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(
                Radius.circular(36),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('data'),
                Text('data'),
                Text('data'),
              ],
            ),
          ),
        ],
      );
    },
  );
}

ListView _tabBarWeatherDataHours() {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 20,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 100,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(
                Radius.circular(36),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('data'),
                Text('data'),
                Text('data'),
              ],
            ),
          ),
        ],
      );
    },
  );
}

TabBar TabBarTitle(ScrollController scrollController) {
  return TabBar(
    tabs: [
      Tab(
        child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.only(top: 14),
          children: const [
            Text(
              'Günlük Hava Durumu',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
      Tab(
        child: ListView(
          padding: const EdgeInsets.only(top: 14),
          controller: scrollController,
          children: const [
            Text(
              'Haftalık Hava Durumu',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
