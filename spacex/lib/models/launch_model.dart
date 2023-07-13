class Launch {
  final String name;
  final String? details;
  final String patch;
  final String videoLink;
  final int flightNumber; // flight number eklendi
  final String dateUtc; // dateUtc eklendi
  final String launchPad; // launchPad eklendi
  final String? landPad; // landPad eklendi. Null olabilir

  Launch(
      {required this.name,
      this.details,
      required this.patch,
      required this.videoLink,
      required this.flightNumber,
      required this.dateUtc,
      required this.launchPad,
      this.landPad});

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      name: json['name'],
      details: json['details'] ?? 'No details available',
      patch: json['links']['patch']['small'],
      videoLink: json['links']['youtube_id'] ?? 'No video available',
      flightNumber: json['flight_number'], // flight_number'ı json'dan alıyoruz
      dateUtc: json['date_utc'], // date_utc'yi json'dan alıyoruz
      launchPad: json['launchpad'], // launchpad'ı json'dan alıyoruz
      landPad: json['landpad'] ??
          'No landing pad available', // landpad'ı json'dan alıyoruz. Eğer null ise default bir mesaj atıyoruz
    );
  }
}
