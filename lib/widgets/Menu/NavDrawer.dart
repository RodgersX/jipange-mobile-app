import 'package:flutter/material.dart';

import './MenuItems.dart';

// ignore: must_be_immutable
class MainDrawer extends StatelessWidget {
  final Widget anyWidget;
  final Color backgroundClr;

  MainDrawer(
      {required this.anyWidget, this.backgroundClr = Colors.white, Key? key})
      : super(key: key);

  double screenHeight = 0;
  double screenWidth = 0;
  final Duration duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      body: Stack(
        children: [
          const MenuDashboardPage(),
          HomeScreen(anyWidget, backgroundClr),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final Widget anyWidget;
  final Color bckClr;

  const HomeScreen(this.anyWidget, this.bckClr, {Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor),
      decoration: BoxDecoration(
        borderRadius:
            isDrawerOpen ? BorderRadius.circular(0) : BorderRadius.circular(17),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.bckClr,
              borderRadius: isDrawerOpen
                  ? BorderRadius.circular(0)
                  : const BorderRadius.only(
                      topLeft: Radius.circular(17),
                    ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(bottom: 15, top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          width: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildMenuBarItems(20),
                              const SizedBox(height: 4),
                              _buildMenuBarItems(15),
                              const SizedBox(height: 4),
                              _buildMenuBarItems(10),
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            xOffset = isDrawerOpen ? 230 : 0;
                            yOffset = isDrawerOpen ? 100 : 0;
                            scaleFactor = isDrawerOpen ? 0.7 : 1;
                            isDrawerOpen = !isDrawerOpen;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.search,
                          // ignore: deprecated_member_use
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: widget.bckClr,
                borderRadius: isDrawerOpen
                    ? BorderRadius.circular(0)
                    : const BorderRadius.only(
                        bottomLeft: Radius.circular(17),
                      ),
              ),
              child: widget.anyWidget,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuBarItems(double width) {
    return Container(
      width: width,
      height: 2,
      // ignore: deprecated_member_use
      decoration: BoxDecoration(color: Theme.of(context).accentColor),
    );
  }
}
