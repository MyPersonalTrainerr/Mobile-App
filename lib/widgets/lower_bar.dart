import 'package:flutter/material.dart';
import 'package:my_pt/screens/exercises_overview.dart';

class LowerBar extends StatefulWidget {
  const LowerBar({Key? key}) : super(key: key);

  @override
  State<LowerBar> createState() => _LowerBarState();
}

class _LowerBarState extends State<LowerBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index, BuildContext context) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const ExersicesOverviewScreen(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const ExersicesOverviewScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return
    BottomNavigationBar(
      selectedItemColor: Colors.white,
      selectedLabelStyle: TextStyle(
        color: Colors.white,
      ),
      unselectedLabelStyle: TextStyle(
        color: Colors.white,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Container(
            // padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(143, 148, 251, .2),
                      blurRadius: 20.0,
                      offset: Offset(0, 10))
                ]),
            child: Icon(Icons.list, color: Theme.of(context).iconTheme.color),
          ),
          label: 'Exercises',
        ),
        BottomNavigationBarItem(
          icon: Container(
            // padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(143, 148, 251, .2),
                      blurRadius: 20.0,
                      offset: Offset(0, 10))
                ]),
            child: Icon(Icons.person, color: Theme.of(context).iconTheme.color),
          ),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: (_selectedIndex) => _onItemTapped(_selectedIndex, context),
    );
  }
}
