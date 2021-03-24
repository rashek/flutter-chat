import 'package:flutter/material.dart';

class PeerProfile extends StatelessWidget {
  static final routeName = '/peer-profile';

  const PeerProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final peerName = routeArgs['peer_name'];
    final peerImage = routeArgs['peer_image'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'PROFILE',
        ),
      ),
      body: Container(
        height: 500,
        padding: EdgeInsets.only(top: 8),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        heightFactor: 1.4,
                        child: CircleAvatar(
                          radius: 90.0,
                          backgroundImage: NetworkImage(peerImage),
                        ),
                      ),
                      // Text(
                      //   userDoc[0]['username'] == null
                      //       ? 'got null'
                      //       : userDoc[0]['username'],
                      //   style:
                      //       TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      // )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                peerName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
