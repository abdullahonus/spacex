import 'package:flutter/foundation.dart';
import 'package:spacex/models/launch_model.dart';
import 'package:spacex/services/launch_services.dart';

class LaunchProvider with ChangeNotifier {
  Launch? _launch;
  LaunchService _launchService = LaunchService();

  Launch? get launch => _launch;

  Future<Launch?> fetchLatestLaunch() async {
    _launch = await _launchService.fetchLatestLaunch();
    notifyListeners();
    return _launch;
  }
}
