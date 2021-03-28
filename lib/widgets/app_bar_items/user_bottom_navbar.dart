import 'package:flutter/material.dart';

// import '../../screens/main_tab_screen.dart';

class UserBottomNavbar extends StatelessWidget {
  final Function selectPage;
  final int index;
  UserBottomNavbar(this.selectPage, this.index);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: selectPage,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.greenAccent[600],
      unselectedItemColor: Colors.black45,
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.message_outlined),
          // ignore: deprecated_member_use
          title: Text('Chat'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notification_important_outlined),
          // ignore: deprecated_member_use
          title: Text('Notification'),
        ),
      ],
    );
  }
}
