import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// relative imports
import '../screens.dart';
import '../../providers/providers.dart';
import '../../Layouts/advisors_layout.dart';
import '../../widgets/widgets.dart';

// ignore: use_key_in_widget_constructors
class AdvisorsList extends StatelessWidget {
  static const routeName = '/advisors-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: advisorspage(context),
    );
  }

  Widget advisorspage(context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    return ChangeNotifierProvider(
      create: (ctx) => AdvisorsProvider(),
      child: AdvisorsLayout(
        panelcontents: advisorlist(context),
        backgroundColor: Theme.of(context).primaryColor,
        maincontent: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AdvisorsDetailsWidget(),
        ),
        panelColor: isDark ? const Color.fromRGBO(52, 52, 52, 1) : Colors.white,
      ),
    );
  }

  Widget advisorlist(context) {
    final advisorsData = Provider.of<AdvisorsProvider>(context);
    final advisors = advisorsData.advisors;

    return Container(
      height: 200,
      margin: const EdgeInsets.only(top: 15),
      child: ListView.builder(
          itemCount: advisors.length,
          itemBuilder: (ctx, i) {
            return InkWell(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 3),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(247, 226, 252, 1),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(advisors[i].image),
                    backgroundColor: Colors.white,
                  ),
                  title: Text(
                    '${advisors[i].first} ${advisors[i].last}',
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                  trailing: const Icon(Icons.arrow_forward),
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(
                  AdvisorView.routeName,
                  arguments: advisors[i].id,
                );
              },
            );
          }),
    );
  }
}


//   (ctx, i) => ChangeNotifierProvider.value(
          //     value: advisors[i],
          //     child: InkWell(
          //       child: Container(
          //         margin: const EdgeInsets.symmetric(vertical: 3),
          //         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          //         decoration: BoxDecoration(
          //             color: Color.fromRGBO(247, 226, 252, 1),
          //             borderRadius: BorderRadius.circular(17)),
          //         child: ListTile(
          //           leading: CircleAvatar(
          //             backgroundImage: NetworkImage(advisors[i].image),
          //             backgroundColor: Colors.white,
          //           ),
          //           title: Text(
          //             '${advisors[i].first} ${advisors[i].last}',
          //             style: TextStyle(fontFamily: 'Poppins'),
          //           ),
          //           trailing: const Icon(Icons.arrow_forward),
          //         ),
          //       ),
          //       onTap: () {
          //         Navigator.of(context).pushNamed(
          //           AdvisorView.routeName,
          //           arguments: advisors[i].id,
          //         );
          //       },
          //     ),
          //   ),
          // ),