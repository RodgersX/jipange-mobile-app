import 'package:app1/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// relative imports
import '../../providers/dark_theme_provider.dart';
import '../../screens/Advisors/advisors_list.dart';
import '../../screens/Budgeting/money_overview.dart';
import '../../screens/Home.dart';
import '../../screens/profile.dart';

class MenuDashboardPage extends StatelessWidget {
  const MenuDashboardPage({Key? key}) : super(key: key);

  Widget _buildListTile(String title, VoidCallback tapHandler) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    return Scaffold(
      backgroundColor: isDark
          ? const Color.fromRGBO(22, 9, 28, 1)
          : const Color.fromRGBO(70, 30, 88, 1),
      body: Stack(
        children: [
          menu(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Menu',
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  IconButton(
                    icon: themeChange.darkTheme
                        ? const Icon(
                            Icons.brightness_2,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.nights_stay,
                            color: Colors.white,
                          ),
                    onPressed: () {
                      themeChange.switchTheme();
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          _buildListTile('Reports', () {}),
          const SizedBox(height: 15),
          _buildListTile('Budget Planner', () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              MoneyOverview.routeName,
              ModalRoute.withName(Homepage.routeName),
            );
          }),
          const SizedBox(height: 15),
          _buildListTile('Profile', () {
            Navigator.of(context).pushReplacementNamed(ProfilePage.routeName);
          }),
          const SizedBox(height: 15),
          _buildListTile('Advisors', () {
            Navigator.of(context).pushReplacementNamed(AdvisorsList.routeName);
          }),
          const SizedBox(height: 15),
          Container(
            width: MediaQuery.of(context).size.width * .55,
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: const Icon(
                Icons.home,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Homepage.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
