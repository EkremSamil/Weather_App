import 'package:flutter/material.dart';

class HomePageTabbarDesign extends StatelessWidget {
  const HomePageTabbarDesign({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight / 2,
      width: screenWidth,
      color: Color(0x945C50E0),
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
    backgroundColor: Color(0xDC281E97),
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBarTitle(scrollController),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  height: 160,
                  child: TabBarView(
                    children: [
                      _tabBarWeatherDataHours(),
                      _tabBarWeatherDataWeeks(),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Card(
                        margin: EdgeInsets.all(14),
                        elevation: 15,
                        color: Color(0xDC1C1571),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.red,
                          ),
                          height: 150,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('AIR QUALITY'),
                                SizedBox(height: 15),
                                Text('3- Low Health Risk'),
                                SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.red,
                              ),
                              margin: EdgeInsets.all(18),
                              width: 56,
                              height: 125,
                            ),
                          ),
                          Expanded(
                            flex: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.red,
                              ),
                              margin: EdgeInsets.all(18),
                              width: 56,
                              height: 125,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.red,
                              ),
                              margin: EdgeInsets.all(18),
                              width: 56,
                              height: 125,
                            ),
                          ),
                          Expanded(
                            flex: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.red,
                              ),
                              margin: EdgeInsets.all(18),
                              width: 56,
                              height: 125,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.red,
                              ),
                              margin: EdgeInsets.all(18),
                              width: 56,
                              height: 125,
                            ),
                          ),
                          Expanded(
                            flex: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.red,
                              ),
                              margin: EdgeInsets.all(18),
                              width: 56,
                              height: 125,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.red,
                              ),
                              margin: EdgeInsets.all(18),
                              width: 56,
                              height: 125,
                            ),
                          ),
                          Expanded(
                            flex: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.red,
                              ),
                              margin: EdgeInsets.all(18),
                              width: 56,
                              height: 125,
                            ),
                          ),
                        ],
                      ),
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
            height: 125,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(4),
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

Widget _tabBarWeatherDataHours() {
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
            height: 125,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(4),
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
