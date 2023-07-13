class Launch {
  final String name;
  final String? details;
  final String patch;
  final String videoLink;
  final int flightNumber;
  final String dateUtc;
  final String launchPad;
  final String? landPad;
  final String? redditDiscussion; // redditDiscussion eklendi. Null olabilir

  Launch(
      {required this.name,
      this.details,
      required this.patch,
      required this.videoLink,
      required this.flightNumber,
      required this.dateUtc,
      required this.launchPad,
      this.landPad,
      this.redditDiscussion});

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      name: json['name'],
      details: json['details'] ?? 'No details available',
      patch: json['links']['patch']['small'],
      videoLink: json['links']['youtube_id'] ?? 'No video available',
      flightNumber: json['flight_number'],
      dateUtc: json['date_utc'],
      launchPad: json['launchpad'],
      landPad: json['landpad'] ?? 'No landing pad available',
      redditDiscussion: json['links']['reddit']['discussion'] ??
          'No discussion available', // redditDiscussion'ı json'dan alıyoruz. Eğer null ise default bir mesaj atıyoruz
    );
  }
}
