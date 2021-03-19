import 'package:flutter/material.dart';

class PeerProfile extends StatelessWidget {
  static final routeName = '/peer-profile';

  const PeerProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final peerName = routeArgs['peer_name'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          peerName,
        ),
      ),
    );
  }
}
