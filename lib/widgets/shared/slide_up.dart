import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlideUp extends StatelessWidget {
  final Widget mainContent;
  final Widget panelContent;
  final Color panelcolor;

  const SlideUp({
    required this.mainContent,
    required this.panelContent,
    required this.panelcolor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final panelOpen = MediaQuery.of(context).size.height * 0.50;
    final panelClosed = MediaQuery.of(context).size.height * 0.1;

    return SlidingUpPanel(
      maxHeight: panelOpen,
      minHeight: panelClosed,
      backdropEnabled: true,
      color: panelcolor,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
      body: Column(
        children: [Expanded(child: mainContent)],
      ),
      panelBuilder: (controller) => panelcontents(context),
    );
  }

  Widget appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, color: Colors.black),
        ),
        const Icon(
          Icons.search,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget panelcontents(context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDragHandle(context),
          const SizedBox(
            height: 23,
          ),
          Expanded(
            child: panelContent,
          ),
        ],
      ),
    );
  }

  Widget buildDragHandle(context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 5.0,
            decoration: BoxDecoration(color: Colors.grey[400]),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
