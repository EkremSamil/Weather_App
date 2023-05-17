import 'export.dart';

class HomePagee extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePagee> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: 0,
            right: 0,
            top: _isMenuOpen ? 0 : screenHeight,
            height: screenHeight,
            child: Container(
              color: Colors.blue, // Menü arkaplan rengi
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isMenuOpen = !_isMenuOpen;
          });
        },
        child: Icon(_isMenuOpen ? Icons.close : Icons.menu),
      ),
    );
  }
}
