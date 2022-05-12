import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// relative paths
import '../../providers/dark_theme_provider.dart';
import '../../widgets/widgets.dart';

class SpecificCatArgs {
  final String title;
  final String tag;
  final String amount;

  SpecificCatArgs(this.amount, this.tag, this.title);
}

// ignore: use_key_in_widget_constructors
class CategoryItem extends StatelessWidget {
  static const routeName = '/category-item';

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    return SafeArea(
      child: MainDrawer(
        anyWidget: Center(
          child: itemdetail(context),
        ),
        backgroundClr: isDark
            ? Theme.of(context).primaryColor
            : const Color.fromRGBO(242, 217, 253, 1),
      ),
    );
  }

  Widget itemdetail(context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as SpecificCatArgs;
    final title = routeArgs.title;
    final amount = routeArgs.amount;
    final tag = routeArgs.tag;

    return Container(
      color: isDark
          ? Theme.of(context).primaryColor
          : const Color.fromRGBO(242, 217, 253, 1),
      child: ListView(
        children: [
          SizedBox(height: 100),
          Center(
            child: Text(
              tag == 'out' ? 'Your spending' : 'You got money from',
              style: TextStyle(
                  color: isDark ? Colors.white : Colors.black, fontSize: 16),
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color:
                    isDark ? const Color(0xFF9367C6) : const Color(0xFF461E58),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            height: 100.0,
            width: 100.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/images/money.png'),
                fit: BoxFit.contain,
              ),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Text(
              'Ksh. $amount',
              style: TextStyle(
                fontSize: 22,
                color:
                    isDark ? const Color(0xFF9367C6) : const Color(0xFF461E58),
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
