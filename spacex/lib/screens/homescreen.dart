import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacex/providers/launch_providers.dart';
import 'package:spacex/screens/launch_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _refreshLaunch(BuildContext context) async {
    await Provider.of<LaunchProvider>(context, listen: false)
        .fetchLatestLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpaceX Latest Launch'),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshLaunch(context),
        child: FutureBuilder(
          future: Provider.of<LaunchProvider>(context, listen: false)
              .fetchLatestLaunch(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.error != null) {
                return Center(child: Text('An error occurred!'));
              } else {
                return Consumer<LaunchProvider>(
                  builder: (ctx, launchData, _) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) =>
                            DetailsScreen(launch: launchData.launch!),
                      ));
                    },
                    child: ListView(
                      children: <Widget>[
                        Text('Name: ${launchData.launch!.name}'),
                        Text('Details: ${launchData.launch!.details}'),
                        Image.network('${launchData.launch!.patch}'),
                      ],
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
