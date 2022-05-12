import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// relative imports
import '../providers/dark_theme_provider.dart';
import '../screens/Category/category_panel.dart';
import '../widgets/Menu/NavDrawer.dart';

class DetailsLayout extends StatelessWidget {
  final Widget details;
  final String listTitle;
  final Color backgroundColor;
  final String tag;

  // ignore: use_key_in_widget_constructors
  const DetailsLayout({
    required this.details,
    required this.listTitle,
    required this.backgroundColor,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MainDrawer(
        anyWidget: layout(context),
        backgroundClr: backgroundColor,
      ),
    );
  }

  Widget layout(context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;
    final panelOpen = MediaQuery.of(context).size.height * 0.7;
    final panelClosed = MediaQuery.of(context).size.height * 0.45;

    return Scaffold(
      body: SlidingUpPanel(
        maxHeight: panelOpen,
        minHeight: panelClosed,
        color: isDark ? const Color.fromRGBO(52, 52, 52, 1) : Colors.white,
        body: Container(
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .4,
                  child: details,
                ),
              ],
            ),
          ),
        ),
        panelBuilder: (_) => PanelWidget(listTitle, tag),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
      ),
    );
  }
}
