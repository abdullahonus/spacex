import 'package:flutter/material.dart';
import '../models/launch_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  final Launch launch;
  final Uri _url = Uri.parse('https://youtu.be/5EwW8ZkArL4');
  final Uri _urlReddit = Uri.parse(
      'https://www.reddit.com/r/spacex/comments/xvm76j/rspacex_crew5_launchcoast_docking_discussion_and/');
  DetailsScreen({super.key, required this.launch});

  Future<void> _launchUrlReddit() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> _launchUrlYoutube() async {
    if (!await launchUrl(_urlReddit)) {
      throw Exception('Could not launch $_url');
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
            Text('Flight Number: ${launch.flightNumber}'),
            SizedBox(height: 8.0),
            Text('Date UTC: ${launch.dateUtc}'),
            SizedBox(height: 8.0),
            Text('Launchpad: ${launch.launchPad}'),
            SizedBox(height: 8.0),
            Text('Landpad: ${launch.landPad}'),
            SizedBox(height: 8.0),
            TextButton(
              child: Text('Watch on YouTube'),
              onPressed:
                  _launchUrlReddit, // YouTube videosunu açmak için _launchURL'ı kullanıyoruz
            ),
            SizedBox(height: 8.0),
            TextButton(
              child: Text('Watch on YouTube'),
              onPressed:
                  _launchUrlYoutube, // YouTube videosunu açmak için _launchURL'ı kullanıyoruz
            ),
          ],
        ),
      ),
    );
  }
}
