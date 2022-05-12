import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// relative imports
import '../../providers/dark_theme_provider.dart';
import '../../widgets/widgets.dart';

// ignore: use_key_in_widget_constructors
class CutExpenditure extends StatelessWidget {
  static const routeName = '/cut-expense';

  Widget _buildDescriptionSection(context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Let\'s do this.',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: isDark ? const Color(0xFF9367C6) : const Color(0xFF461E58),
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
        ),
        _desc('You could cut all your expenses by a fixed percentage below.'),
        _desc('You may also choose to set specific budgets by category.')
      ],
    );
  }

  Container _desc(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 17,
          color: Color.fromRGBO(123, 122, 122, 1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MainDrawer(
          anyWidget: _buildExpenditureSection(context),
          backgroundClr: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildExpenditureSection(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListView(
        children: [
          _buildDescriptionSection(context),
          const CutExpenditurePerc(),
        ],
      ),
    );
  }
}
