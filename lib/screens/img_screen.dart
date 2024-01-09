import 'package:bleepy_flutter_example/configs/env_config.dart';
import 'package:bleepy_flutter_example/models/launcher_urls_model.dart';
import 'package:bleepy_flutter_example/screens/bleepy_screen.dart';
import 'package:flutter/material.dart';

const String NURTURE_GAME_URL =
    'https://launcher.bleepy.net?userKey=khhong100&secretKey=5aa50b0b7a815152a3cb7516f414bf5f6a1c99b8da6129763d1038441907cafd&platform=flutter';
const String CARD_GAME_URL =
    'https://launcher.bleepy.net?userKey=khhong100&secretKey=12ba66af8a86ba7bdcc21203b4f346490ea822dd7e2226007d6b7cea99547575&platform=flutter';


class ImgScreen extends StatefulWidget {
  final String userkey;
  const ImgScreen({super.key, required this.userkey});

  @override
  State<ImgScreen> createState() => _ImgScreenState();
}

class _ImgScreenState extends State<ImgScreen> {
  EnvConfig envConfig = EnvConfig();

  @override
  Widget build(BuildContext context) {
    final LauncherUrlsModel launcherUrls = envConfig.getLauncherUrl(widget.userkey);
    print('launcherUrls: $launcherUrls');
    return SafeArea(
        bottom: false,
        child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/ios_bg_02.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.70,
                  left: MediaQuery.of(context).size.width * 0.25,
                  child: Container(
                    width: 60,
                    height: 100,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) => BleepyLauncherScreen(launcherUrl: launcherUrls.cowUrl), // 소키우기
                              transitionDuration: const Duration(seconds: 0),
                            )
                        );
                      },
                      child: Container(
                        // 필요한 경우 추가 스타일링
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.70,
                  left: MediaQuery.of(context).size.width * 0.45,
                  child: Container(
                    width: 60,
                    height: 100,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) => BleepyLauncherScreen(launcherUrl: launcherUrls.coffeeUrl), // 커피콩키우기
                              transitionDuration: const Duration(seconds: 0),
                            )
                        );
                      },
                      child: Container(
                        // 필요한 경우 추가 스타일링
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.70,
                  right: MediaQuery.of(context).size.width * 0.18,
                  child: Container(
                    width: 60,
                    height: 100,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) => BleepyLauncherScreen(launcherUrl: launcherUrls.cardUrl), // 카드게임
                              transitionDuration: const Duration(seconds: 0),
                            )
                        );
                      },
                      child: Container(
                        // 필요한 경우 추가 스타일링
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
