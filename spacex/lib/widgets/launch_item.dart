/* import 'package:flutter/material.dart';
import 'package:spacex/models/launch_model.dart';
import 'package:spacex/screens/launch_detail_screen.dart';

class LaunchItem extends StatelessWidget {
  final Launch launch;

  LaunchItem(this.launch);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => LaunchDetailScreen(launch),
        ));
      },
      child: ListTile(
        title: Text(launch.name),
        subtitle: Text(launch.details ?? "null"),
      ),
    );
  }
}
 */