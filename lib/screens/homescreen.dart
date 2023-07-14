import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spacex/providers/launch_providers.dart';
import 'package:spacex/screens/launch_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _refreshLaunch(BuildContext context) async {
    await Provider.of<LaunchProvider>(context, listen: false)
        .fetchLatestLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: 0.6,
                    fit: BoxFit.cover,
                    image: AssetImage("assets/background/background.png"))),
          ),
          RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _refreshLaunch;
              });
            },
            child: FutureBuilder(
              future: Provider.of<LaunchProvider>(context, listen: false)
                  .fetchLatestLaunch(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ));
                } else {
                  if (snapshot.error != null) {
                    return const Center(child: Text('An error occurred!'));
                  } else {
                    return Consumer<LaunchProvider>(
                      builder: (ctx, launchData, _) => GestureDetector(
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 30),
                              child: Image.asset(
                                "assets/logo/logo.png",
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                launchData.launch!.patch,
                                height: 350,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return SizedBox(
                                    height: 350,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 80.0),
                              child: Text(
                                launchData.launch!.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            animatedText(
                              Center(
                                child: DefaultTextStyle(
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  child: AnimatedTextKit(
                                    isRepeatingAnimation: true,
                                    pause: const Duration(seconds: 2),
                                    repeatForever: true,
                                    animatedTexts: [
                                      TypewriterAnimatedText(
                                        'Welcome to Crew5 information app!',
                                      ),
                                      TypewriterAnimatedText(
                                        'Rocket Flight Number: ${launchData.launch!.flightNumber}',
                                      ),
                                      TypewriterAnimatedText(
                                        'Flight Date: ${DateFormat("dd-MM-yyyy HH:mm").format(DateTime.parse(launchData.launch!.dateUtc))}',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 80.0),
                              child: GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (ctx) =>
                                      DetailsScreen(launch: launchData.launch!),
                                )),
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'For More ',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.4),
                                          fontSize: 15),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Details',
                                            style: TextStyle(
                                                color: Colors.amber[300],
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

animatedText(widget) {
  return TweenAnimationBuilder<double>(
    tween: Tween<double>(begin: 0.0, end: 1.0),
    curve: Curves.ease,
    duration: const Duration(seconds: 2),
    builder: (BuildContext context, double opacity, Widget? child) {
      return Opacity(
        opacity: opacity,
        child: widget,
      );
    },
  );
}
