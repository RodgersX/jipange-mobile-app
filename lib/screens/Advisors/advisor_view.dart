import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// relative imports
import '../../providers/providers.dart';
import '../../screens/Advisors/message_advisor.dart';
import '../../widgets/widgets.dart';

// ignore: must_be_immutable
// ignore: use_key_in_widget_constructors
class AdvisorView extends StatelessWidget {
  static const routeName = '/advisor-view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MainDrawer(
          anyWidget: mainview(context),
          backgroundClr: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget mainview(context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;
    final advisorId = ModalRoute.of(context)!.settings.arguments as String;
    final advisor = Provider.of<AdvisorsProvider>(context).findById(advisorId);

    return Material(
      elevation: 8,
      child: SlideUp(
        mainContent: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(advisor.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        panelContent: _buildPanelContents(context),
        panelcolor: isDark
            ? Theme.of(context).primaryColor.withOpacity(.8)
            : const Color(0xFF461E58).withOpacity(.8),
      ),
    );
  }

  Widget _buildPanelContents(context) {
    final advisorId = ModalRoute.of(context)!.settings.arguments as String;
    final advisor = Provider.of<AdvisorsProvider>(context).findById(advisorId);

    return Container(
      height: 80,
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${advisor.first} ${advisor.last}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Icon(
                      Icons.thumb_up,
                      size: 14,
                      color: Colors.purpleAccent[100],
                    ),
                    onTap: () {
                      // Navigator.of(context).pushNamed(
                      //   MessageAdvisor.routeName,
                      //   arguments: advisor.id,
                      // );
                    },
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Icon(
                      Icons.thumb_down,
                      size: 14,
                      color: Colors.red[300],
                    ),
                    onTap: () {
                      // Navigator.of(context).pushNamed(
                      //   MessageAdvisor.routeName,
                      //   arguments: advisor.id,
                      // );
                    },
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Icon(
                      Icons.messenger_sharp,
                      size: 15,
                      color: Colors.purple[700],
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        MessageAdvisor.routeName,
                        arguments: advisor.id,
                      );
                    },
                  ),
                ],
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: const Color.fromRGBO(255, 255, 255, 0.46).withOpacity(.4),
            ),
            child: const Text(
              'Has helped over 1000 people transform their lives. A graduate from Havard and has been a master of the craft for the last 15 years. \nHas helped over 1000 people transform their lives. A graduate from Havard and has been a master of the craft for the last 15 years.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
