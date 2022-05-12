import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// relative imports
import '../../providers/dark_theme_provider.dart';

class CategoryBuildDragHandle extends StatelessWidget {
  final String listTitle;

  const CategoryBuildDragHandle(this.listTitle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    return Center(
      child: Column(
        children: [
          const SizedBox(height: 15),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 5,
            decoration: BoxDecoration(color: Colors.grey[300]),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            listTitle,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
          )
        ],
      ),
    );
  }
}
