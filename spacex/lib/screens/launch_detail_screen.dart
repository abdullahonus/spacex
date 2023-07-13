import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/launch_model.dart';

class DetailsScreen extends StatelessWidget {
  final Launch launch;

  DetailsScreen({required this.launch});

  void _launchURL() async {
    final url = 'https://www.youtube.com/watch?v=${launch.videoLink}';
    if (await canLaunch(url)) {
      await launch;
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Launch Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name: ${launch.name}'),
            SizedBox(height: 8.0),
            Text('Details: ${launch.details}'),
            SizedBox(height: 8.0),
            Text(
                'Flight Number: ${launch.flightNumber}'), // Flight Number bilgisini ekrana bastırıyoruz
            SizedBox(height: 8.0),
            Text(
                'Date UTC: ${launch.dateUtc}'), // Date UTC bilgisini ekrana bastırıyoruz
            SizedBox(height: 8.0),
            Text(
                'Launchpad: ${launch.launchPad}'), // Launchpad bilgisini ekrana bastırıyoruz
            SizedBox(height: 8.0),
            Text(
                'Landpad: ${launch.landPad}'), // Landpad bilgisini ekrana bastırıyoruz
            SizedBox(height: 8.0),
            TextButton(
              child: Text('Watch on YouTube'),
              onPressed: _launchURL,
            ),
          ],
        ),
      ),
    );
  }
}
