import 'package:flutter/material.dart';

// relative imports
import '../widgets/widgets.dart';

class AdvisorsLayout extends StatelessWidget {
  final Widget maincontent;
  final Color backgroundColor;
  final Widget panelcontents;
  final Color panelColor;

  // ignore: use_key_in_widget_constructors
  const AdvisorsLayout({
    required this.maincontent,
    required this.backgroundColor,
    required this.panelcontents,
    required this.panelColor,
  });
  @override
  Widget build(BuildContext context) {
    return MainDrawer(
      anyWidget: layout(context),
      backgroundClr: Theme.of(context).primaryColor,
    );
  }

  Widget layout(context) {
    return Container(
      color: backgroundColor,
      child: SlideUp(
        mainContent: Container(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              maincontent,
            ],
          ),
        ),
        panelContent: panelcontents,
        panelcolor: panelColor,
      ),
    );
  }
}
