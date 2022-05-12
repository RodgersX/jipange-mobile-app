import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// relative imports
import '../../providers/advisors.dart';
import '../../providers/dark_theme_provider.dart';
import '../../screens/Advisors/advisor_view.dart';

// ignore: use_key_in_widget_constructors
class AdvisorsDetailsWidget extends StatefulWidget {
  @override
  _AdvisorsDetailsWidgetState createState() => _AdvisorsDetailsWidgetState();
}

class _AdvisorsDetailsWidgetState extends State<AdvisorsDetailsWidget> {
  // late Future _advisorFuture;
  final TextEditingController _searchItemController = TextEditingController();

  // Future _obtainAdvisorsFuture() {
  //   return Provider.of<AdvisorsProvider>(context, listen: false)
  //       .fetchAdvisors();
  // }

  // @override
  // void initState() {
  //   _advisorFuture = _obtainAdvisorsFuture();
  //   super.initState();
  // }

  // @override
  // void didChangeDependencies() {
  //   Provider.of<AdvisorsProvider>(context).fetchAdvisors();

  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Financial',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 25.0,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Advisors',
              style: TextStyle(
                fontFamily: 'Poppins',
                color:
                    isDark ? const Color(0xFF9367C6) : const Color(0xFF461E58),
                fontSize: 30.0,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark
                  ? const Color.fromRGBO(244, 227, 252, 1)
                  : const Color.fromRGBO(252, 240, 255, 1),
              borderRadius: BorderRadius.circular(21),
            ),
            alignment: Alignment.centerLeft,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 7,
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: isDark
                            ? const Color(0xFF9367C6)
                            : const Color(0xFF461E58),
                      ),
                    ],
                  ),
                ),
                TextField(
                  style: TextStyle(
                    color: isDark
                        ? const Color(0xFF9367C6)
                        : const Color(0xFF461E58),
                  ),
                  controller: _searchItemController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 35, right: 15),
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      color: isDark
                          ? const Color(0xFF9367C6)
                          : const Color(0xFF461E58),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Get back in touch with:',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            height: 100,
            child: profileList(context),
          )
        ],
      ),
    );
  }

  Widget profileList(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;
    final advisorData = Provider.of<AdvisorsProvider>(context);
    final advisors = advisorData.advisors;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: advisors.length,
      itemBuilder: (ctx, i) => Container(
        margin: const EdgeInsets.only(right: 15),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AdvisorView.routeName,
              arguments: advisors[i].id,
            );
          },
          child: SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(advisors[i].image),
                      radius: 25.0,
                    ),
                    Positioned(
                      right: 2,
                      top: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 10,
                          minHeight: 10,
                        ),
                        child: const SizedBox(
                          width: 1,
                          height: 1,
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  '${advisors[i].first}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: isDark
                        ? Colors.white
                        : const Color.fromRGBO(52, 52, 52, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// FutureBuilder(
          //   future: _advisorFuture,
          //   builder: (ctx, dataSnapShot) {
          //     if (dataSnapShot.connectionState == ConnectionState.waiting) {
          //       return const Center(
          //         child: Padding(
          //           padding: EdgeInsets.all(20),
          //           child: CircularProgressIndicator(),
          //         ),
          //       );
          //     } else {
          //       if (dataSnapShot.error != null) {
          //         return Container(
          //           margin: const EdgeInsets.only(top: 20),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               const Icon(
          //                 Icons.error_outline,
          //                 color: Colors.grey,
          //                 size: 100,
          //               ),
          //               const Padding(
          //                 padding: EdgeInsets.symmetric(horizontal: 10),
          //                 child: Text(
          //                   'Something went wrong!',
          //                   style: TextStyle(color: Colors.grey),
          //                   textAlign: TextAlign.center,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         );
          //       } else {
          //         return Container(
          //           alignment: Alignment.centerLeft,
          //           margin: const EdgeInsets.symmetric(vertical: 12.0),
          //           height: 70.0,
          //           child: profileList(context),
          //         );
          //       }
          //     }
          //   },
          // )