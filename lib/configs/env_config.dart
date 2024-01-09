
import 'package:bleepy_flutter_example/models/launcher_urls_model.dart';

class EnvConfig {
  static const COW_URL = 'https://cow.bleepy.net';
  static const BLEEPY_MODE_TEST = 'test'; // 테스트용 앱
  static const BLEEPY_MODE_RELEASE = 'release'; // 시연용 앱

  static const BLEEPY_APP_MODE = BLEEPY_MODE_TEST; // 앱 배포 별로 BLEEPY_MODE_TEST 이거나 BLEEPY_MODE_RELEASE

  final LauncherUrlsModel TEST_LAUNCHER_URLS = LauncherUrlsModel(
    cowUrl: "https://stg-launcher.bleepy.net?userKey={userKey}&secretKey=66d4dadc7e741183aaa008cc82cba24fe690c171bdd666ef214bff974036dd4c&cycle=0&platform=flutter",
    coffeeUrl: "https://stg-launcher.bleepy.net?userKey={userKey}&secretKey=66d4dadc7e741183aaa008cc82cba24fe690c171bdd666ef214bff974036dd4c&cycle=0&characters=6000&platform=flutter",
    cardUrl: "https://stg-launcher.bleepy.net?userKey={userKey}&secretKey=28880fff40a74bbc1192e7d1b752dca55b4361c7c0e09821b7a5b2ce164bc8ba&platform=flutter",
  );

  final LauncherUrlsModel RELEASE_LAUNCHER_URLS = LauncherUrlsModel(
    cowUrl: "https://stg-launcher.bleepy.net?userKey={userKey}&secretKey=cdd865d654087c4311301163709e74ae84e652d4b5e82d5c9d03c77953c700b9&cycle=0&platform=flutter",
    coffeeUrl: "https://stg-launcher.bleepy.net?userKey={userKey}&secretKey=c2b0a56fef06b9e224f4c905dd9feeaf27d976de362ab01be8aa3e0631a92cf6&cycle=0&characters=6000&platform=flutter",
    cardUrl: "https://stg-launcher.bleepy.net/?userKey={userKey}&secretKey=454f36fb500a6c84e2fbd6f5345a394cfe705143f4d0a74c7ad9051c64e3e485&platform=flutter",
  );

  LauncherUrlsModel getLauncherUrl(String userKey) {
    if (BLEEPY_APP_MODE == BLEEPY_MODE_RELEASE) {
      return RELEASE_LAUNCHER_URLS.replaceUserKey(userKey);
    }

    return TEST_LAUNCHER_URLS.replaceUserKey(userKey);
  }
}
