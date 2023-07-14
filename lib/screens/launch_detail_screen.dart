// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:spacex/providers/launch_providers.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:spacex/services/land_pad_services.dart';

import '../models/launch_model.dart';

class DetailsScreen extends StatefulWidget {
  final Launch launch;

  DetailsScreen({
    Key? key,
    required this.launch,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final Uri _urlWikipedia =
      Uri.parse('https://en.wikipedia.org/wiki/SpaceX_Crew-5');

  final Uri _urlYoutube = Uri.parse('https://youtu.be/5EwW8ZkArL4');

  final Uri _urlReddit = Uri.parse(
      'https://www.reddit.com/r/spacex/comments/xvm76j/rspacex_crew5_launchcoast_docking_discussion_and/');

  Future<void> _launchUrlYoutube() async {
    if (!await launchUrl(_urlYoutube)) {
      throw Exception('Could not launch $_urlYoutube');
    }
  }

  Future<void> _launchUrlReddit() async {
    if (!await launchUrl(_urlReddit)) {
      throw Exception('Could not launch $_urlReddit');
    }
  }

  Future<void> _launchUrlWikipedia() async {
    if (!await launchUrl(_urlWikipedia)) {
      throw Exception('Could not launch $_urlWikipedia');
    }
  }

  Future<void> _refreshLaunch(BuildContext context) async {
    await Provider.of<LaunchProvider>(context, listen: false)
        .fetchLatestLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Image.asset(
          "assets/logo/logo.png",
          fit: BoxFit.fitHeight,
          alignment: Alignment.center,
          color: Colors.white,
          scale: 3,
        ),
        backgroundColor: Colors.transparent,
      ),
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (widget.launch.landPad != null)
                      FutureBuilder<LandPad>(
                        future: LandPad.fetchLandPad(widget.launch.landPad!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.white,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final landPadData = snapshot.data!;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: Image.asset(
                                    "assets/crew5.png",
                                    scale: 1.5,
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextButton(
                                              onPressed: _launchUrlReddit,
                                              child: Text(
                                                ' Reddit',
                                                style: TextStyle(
                                                    color: Colors.orange[900]),
                                              ),
                                            ),
                                            Image.asset(
                                              "assets/linkLogos/reddit.png",
                                              scale: 100,
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextButton(
                                              onPressed: _launchUrlYoutube,
                                              child: const Text(
                                                'Youtube',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                            Image.asset(
                                              "assets/linkLogos/youtube.png",
                                              scale: 80,
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextButton(
                                              onPressed: _launchUrlWikipedia,
                                              child: const Text(
                                                'Wikipedia',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Image.asset(
                                              "assets/linkLogos/Wikipedia.png",
                                              scale: 7,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                animatedText(
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AnimatedTextKit(
                                        isRepeatingAnimation: true,
                                        pause: const Duration(seconds: 2),
                                        repeatForever: true,
                                        animatedTexts: [
                                          TypewriterAnimatedText(
                                              'Launch Success:',
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 5, 25, 54)
                                        .withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        " ${widget.launch.launchSuccess}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w100),
                                      ),
                                      Icon(
                                        Icons.circle,
                                        color:
                                            widget.launch.launchSuccess == true
                                                ? Colors.green
                                                : Colors.red,
                                      )
                                    ],
                                  ),
                                ),
                                TextWidget(
                                  description: " ${landPadData.locality}",
                                  title: 'Locality:',
                                ),
                                TextWidget(
                                  description: '${landPadData.region}',
                                  title: 'Region: ',
                                ),
                                animatedText(
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AnimatedTextKit(
                                        isRepeatingAnimation: true,
                                        pause: const Duration(seconds: 2),
                                        repeatForever: true,
                                        animatedTexts: [
                                          TypewriterAnimatedText("Details: ",
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                                  255, 5, 25, 54)
                                              .withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: ReadMoreText(
                                          '${landPadData.details}',
                                          trimLines: 5,
                                          preDataTextStyle: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w100,
                                              color: Colors.white,
                                              fontSize: 20),
                                          trimMode: TrimMode.Line,
                                          colorClickableText: Colors.amber,
                                          trimCollapsedText: ' Read More',
                                          trimExpandedText: ' Hide More',
                                          moreStyle: const TextStyle(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TextWidget(
                                  description: DateFormat("dd-MM-yyyy HH:mm")
                                      .format(DateTime.parse(
                                          widget.launch.dateUtc)),
                                  title: 'Date UTC: ',
                                ),
                                TextWidget(
                                  description: widget.launch.launchPad,
                                  title: 'Launchpad: ',
                                ),
                                TextWidget(
                                  description: ' ${widget.launch.landPad}',
                                  title: 'Landpad:',
                                ),
                              ],
                            );
                          }
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextWidget extends StatefulWidget {
  String description;
  String title;

  TextWidget({
    Key? key,
    required this.description,
    required this.title,
  }) : super(key: key);

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return animatedText(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedTextKit(
            isRepeatingAnimation: true,
            pause: const Duration(seconds: 2),
            repeatForever: true,
            animatedTexts: [
              TypewriterAnimatedText(widget.title,
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 5, 25, 54).withOpacity(0.6),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              widget.description,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w100),
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
