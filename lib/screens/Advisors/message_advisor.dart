// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// relative imports
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

// ignore: use_key_in_widget_constructors
class MessageAdvisor extends StatelessWidget {
  static const routeName = '/message-advisor';

  @override
  Widget build(BuildContext context) {
    final advisorId = ModalRoute.of(context)!.settings.arguments as String;
    final advisor = Provider.of<AdvisorsProvider>(context).findById(advisorId);

    return SafeArea(
      child: Scaffold(
        body: SlideUp(
          mainContent: MainItems(advisor),
          panelContent: PanelItems(),
          panelcolor: Theme.of(context).primaryColor.withOpacity(.8),
        ),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class PanelItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: AdvisorMessageWidget(),
        ),
        const _ActionBar(),
      ],
    );
  }
}

// ignore: must_be_immutable
class MainItems extends StatelessWidget {
  Advisor advisor;

  MainItems(this.advisor);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(advisor.image),
              ),
              const SizedBox(height: 15),
              Text(
                '${advisor.first} ${advisor.last}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Theme.of(context).accentColor,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Online',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.green[400],
                ),
              ),
              const SizedBox(height: 10),
              Icon(
                Icons.search,
                color: Theme.of(context).accentColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionBar extends StatefulWidget {
  const _ActionBar({Key? key}) : super(key: key);

  @override
  __ActionBarState createState() => __ActionBarState();
}

class __ActionBarState extends State<_ActionBar> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    debugPrint('sending messge');
    _messageController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;
    final advisorId = ModalRoute.of(context)!.settings.arguments as String;
    final advisor = Provider.of<AdvisorsProvider>(context).findById(advisorId);

    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 2,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                CupertinoIcons.camera_fill,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TextField(
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Message ${advisor.first}',
                  hintStyle: TextStyle(color: Theme.of(context).accentColor),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 24.0, bottom: 4, top: 5),
            child: GlowingActionButton(
              color: isDark
                  ? const Color.fromRGBO(70, 30, 88, 1)
                  : const Color.fromRGBO(70, 30, 88, 1).withOpacity(.1),
              icon: Icons.send_rounded,
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
