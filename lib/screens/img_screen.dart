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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Stack(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg_sample.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.45,
                  left: MediaQuery.of(context).size.width * 0.17,
                  child: Container(
                    width: 80,
                    height: 100,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) => BleepyLauncherScreen(launcherUrl: 'https://launcher.bleepy.net?userKey=${widget.userkey}&secretKey=5aa50b0b7a815152a3cb7516f414bf5f6a1c99b8da6129763d1038441907cafd&platform=flutter'),
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
                  top: MediaQuery.of(context).size.height * 0.45,
                  right: MediaQuery.of(context).size.width * 0.26,
                  child: Container(
                    width: 80,
                    height: 100,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) => BleepyLauncherScreen(launcherUrl: 'https://launcher.bleepy.net?userKey=${widget.userkey}&secretKey=12ba66af8a86ba7bdcc21203b4f346490ea822dd7e2226007d6b7cea99547575&platform=flutter'),
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
