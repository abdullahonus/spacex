class Launch {
  final String name;
  final String? details;
  final String patch;
  final String videoLink;
  final int flightNumber;
  final String dateUtc;
  final String launchPad;
  final String? landPad;
  final String? redditDiscussion;
  final bool? launchSuccess;
  final String? videoLinks;
  Launch(
      {required this.name,
      this.details,
      required this.patch,
      required this.videoLink,
      required this.flightNumber,
      required this.dateUtc,
      required this.launchPad,
      this.landPad,
      this.redditDiscussion,
      required this.launchSuccess,
      this.videoLinks});

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      name: json['name'],
      details: json['details'] ?? 'No details available',
      patch: json['links']['patch']['large'],
      videoLink: json['links']['youtube_id'] ?? 'No video available',
      flightNumber: json['flight_number'],
      dateUtc: json['date_utc'],
      launchPad: json['launchpad'],
      landPad: json['cores'][0]['landpad'],
      redditDiscussion:
          json['links']['reddit']['discussion'] ?? 'No discussion available',
      launchSuccess: json['success'],
      videoLinks: json['links']['youtube_id'] ?? 'No video available',
    );
  }
}
