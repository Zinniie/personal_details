import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slack & GitHub App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display Slack Identity
            Text(
              'Your Slack Name',
              style: TextStyle(fontSize: 24),
            ),
            Image.network(
              'URL_TO_YOUR_SLACK_PROFILE_PICTURE',
              width: 100,
              height: 100,
            ),
            // Open GitHub Button
            GestureDetector(
              onTap: () async {
                final String googleMapsUrl = "https://github.com/Zinniie";

                if (await canLaunch(googleMapsUrl)) {
                  await launch(googleMapsUrl);
                } else {
                  throw "Could not open Google Maps.";
                }
              },
              child: Text('Open GitHub'),
            ),
          ],
        ),
      ),
    );
  }
}
// https://github.com/Zinniie