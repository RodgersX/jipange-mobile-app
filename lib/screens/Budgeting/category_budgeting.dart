import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// relative imports
import '../../providers/dark_theme_provider.dart';
import '../../widgets/widgets.dart';

// ignore: use_key_in_widget_constructors
class BudgetCategories extends StatelessWidget {
  static const routeName = 'budget-categories';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MainDrawer(
          anyWidget: budgetpage(context),
          backgroundClr: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget budgetpage(context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListView(
        children: [
          const SizedBox(height: 15),
          Text(
            'Your Categories:',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: isDark ? const Color(0xFF9367C6) : const Color(0xFF461E58),
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 15),
          BudgetCategoryList(),
        ],
      ),
    );
  }
}
