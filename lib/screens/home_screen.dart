import 'package:artistic_multilingual_keyboards/artistic_multilingual_keyboard.dart';
import 'package:bleepy_flutter_example/screens/img_screen.dart';
import 'package:flutter/material.dart';

const String NURTURE_GAME_URL =
    'https://launcher.bleepy.net?userKey=khhong100&secretKey=5aa50b0b7a815152a3cb7516f414bf5f6a1c99b8da6129763d1038441907cafd&platform=flutter';
const String CARD_GAME_URL =
    'https://launcher.bleepy.net?userKey=khhong100&secretKey=12ba66af8a86ba7bdcc21203b4f346490ea822dd7e2226007d6b7cea99547575&platform=flutter';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  FocusNode engFocusNode = FocusNode();

  late TextEditingController currentKeyboardTEController;
  late FocusNode currentKeyboardFocusNode;
  KeyboardLanguages currentKeyboardLanguage = KeyboardLanguages.english;
  KeyboardAction currentKeyboardAction = KeyboardAction.actionNext;

  bool _isKeyboardOpen = false;

  @override
  void initState() {
    super.initState();
    currentKeyboardTEController = controller;
    currentKeyboardFocusNode = engFocusNode;

    engFocusNode.addListener(() {
      setState(() {
        if(engFocusNode.hasFocus){
          currentKeyboardFocusNode = engFocusNode;
          currentKeyboardAction = KeyboardAction.actionNext;
          currentKeyboardTEController = controller;
          currentKeyboardLanguage = KeyboardLanguages.english;
          _isKeyboardOpen = true;
        }else{
          _isKeyboardOpen = false;
        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    void submit() {
      if (!_formKey.currentState!.validate()) return;

      String userkey = controller.text;

      Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => ImgScreen(userkey: userkey),
            transitionDuration: const Duration(seconds: 0),
          )
      );

      controller.clear();
    }

    return SafeArea(
        // bottom: false,
        child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            body: GestureDetector(
                onTap: () {
                  engFocusNode.unfocus();
                },
                child: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            controller: controller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter userKey';
                              }
                              return null;
                            },
                            focusNode: engFocusNode,
                            textDirection: TextDirection.ltr,
                            readOnly: true,
                            showCursor: true,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              hintText: 'userKey',
                              hintStyle:  TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                              border:  OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              contentPadding:  EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: submit,
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ),
              bottomSheet: KeyboardLayouts(
                textEditingController: currentKeyboardTEController,
                focusNode: currentKeyboardFocusNode,
                isKeyboardOpen: _isKeyboardOpen,
                enableLanguageButton: false,
                keyboardBackgroundColor: Colors.white,
                keysBackgroundColor: Colors.white,
                keyTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
                // keyElevation: 10,
                keyShadowColor: Colors.black,
                keyBorderRadius: BorderRadius.circular(8),
                keyboardAction: currentKeyboardAction,
                currentKeyboardLanguage: currentKeyboardLanguage,
                keyboardActionNextEvent: (){
                  if(engFocusNode.hasFocus){
                    engFocusNode.unfocus();
                  }
                },
                keyboardActionDoneEvent: (){
                  setState(() {
                    _isKeyboardOpen = !_isKeyboardOpen;
                  });
                },
              ),));
  }
}
