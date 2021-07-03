import 'package:flutter/material.dart';

// import '../../screens/main_tab_screen.dart';

class UserAppNavbar extends StatelessWidget {
  final Function selectPage;
  final int index;
  UserAppNavbar(this.selectPage, this.index);
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.deepPurple,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[],
      ),
    );
  }
}
