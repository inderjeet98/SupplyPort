import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:octo_image/octo_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/src/rendering/box.dart';
import 'package:pinput/pinput.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/home.dart';
import '../onbording/onbording.dart';

//model
import '../../model/login_model.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  double? deviceHeight;
  late double deviceWidth;
  List<LoginData> party = [];

  String? password, user_Name;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  final titleController = TextEditingController();

  final amountController = TextEditingController();

  final _pinPutController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;

  void submitData() {
    final enteredTitle = titleController.text;
    final enterAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enterAmount <= 0) {
      return;
    }
  }

  bool _passwordVisible = true;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldState,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Container(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          child: Column(
            children: const [
              Text(
                '',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(29, 55, 84, 1),
                    fontFamily: 'Arboria-Medium',
                    fontSize: 20,
                    letterSpacing: 0.46000000834465027,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )
            ],
          ),
        ),
        centerTitle: true,
        // systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const Onbording(),
                ),
              );
            },
            child: Container(
              height: 25,
              width: 25,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 2,
                    spreadRadius: 2,
                    color: Color.fromRGBO(211, 209, 216, 0.25),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                  color: Color.fromRGBO(
                      29, 55, 84, 1), // Change Custom Drawer Icon Color
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Home(),
                    ),
                  );
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
            // ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: deviceWidth,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 1.35,
                  child: OctoImage(
                    image: CachedNetworkImageProvider(
                        'http://staging.ireckoner.com:9898/92000067/Images/Login.PNG'),
                    width: MediaQuery.of(context).size.width,
                    height: deviceHeight,
                    errorBuilder: OctoError.icon(color: Colors.black),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0.0,
            width: deviceWidth,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.65,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: SizedBox(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Form(
                                key: _formkey,
                                // child: Card(
                                child: Column(
                                  children: [
                                    loginTxt(),
                                    userTxt(),
                                    userName(),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.6,
                                    ),
                                    reqOtpBtn(),
                                  ],
                                ),
                                // )
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  backBtn() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Onbording(),
            ),
          );
        },
        child: Container(
          height: 25,
          width: 25,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 2,
                spreadRadius: 2,
                color: Color.fromRGBO(211, 209, 216, 0.25),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Color.fromRGBO(
                  29, 55, 84, 1), // Change Custom Drawer Icon Color
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const Home(),
                ),
              );
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
        // ),
      ),
    );
  }

  loginTxt() {
    return Padding(
        padding:
            EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0, bottom: 20),
        child: Align(
          alignment: Alignment.center,
          child: new Text(
            'Login',
            style: TextStyle(
                fontFamily: 'Arboria-Medium',
                fontSize: 32,
                letterSpacing: 0.46000000834465027,
                fontWeight: FontWeight.normal,
                color: Color.fromRGBO(29, 55, 84, 1)),
          ),
        ));
  }

  userTxt() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 30.0, bottom: 5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.2,
            child: new Text(
              'Mobile no.',
              style: TextStyle(
                fontFamily: 'Arboria-Medium',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 0.46000000834465027,
                color: Color.fromRGBO(29, 55, 84, 1),
              ),
            ),
          ),
        ));
  }

  userName() {
    return Padding(
      padding: EdgeInsets.all(2),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.2,
        child: new TextFormField(
          keyboardType: TextInputType.text,
          // obscureText: true,
          controller: nameController,
          onSaved: (String? value) {
            user_Name = value;
          },
          decoration: InputDecoration(
              // prefixIcon: Icon(Icons.lock_outline),
              hintText: 'Enter Mobile no.',
              prefixIconConstraints:
                  BoxConstraints(minWidth: 40, maxHeight: 20),
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ),
      ),
    );
  }

  passTxt() {
    return Padding(
        padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 30.0, bottom: 5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: new Text(
            'Password',
            style: TextStyle(
              fontFamily: 'Arboria-Medium',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 0.46000000834465027,
              color: Color.fromRGBO(29, 55, 84, 1),
            ),
          ),
        ));
  }

  setPass() {
    return Padding(
      padding: EdgeInsets.all(2),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.2,
        child: new TextFormField(
          keyboardType: TextInputType.text,
          controller: passwordController,
          obscureText: !_passwordVisible,
          onSaved: (String? value) {
            password = value;
          },
          decoration: InputDecoration(
              // prefixIcon: Icon(Icons.lock_outline),
              hintText: 'Enter password',
              prefixIconConstraints:
                  BoxConstraints(minWidth: 40, maxHeight: 20),
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ),
      ),
    );
  }

  reqOtpBtn() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () => _otpModalpopUp(),
        child: Container(
          height: 42.0,
          width: MediaQuery.of(context).size.width / 1.2,
          child: Center(
            child: Text(
              "REQUEST OTP",
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Arboria-Medium',
                  fontSize: 15,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(122, 128, 190, 0.1599999964237213),
                  offset: Offset(0, 10),
                  blurRadius: 40)
            ],
            color: Color.fromRGBO(29, 55, 84, 1),
          ),
        ),
      ),
    );
  }

  void _otpModalpopUp() {
    _scaffoldState.currentState!.showBottomSheet(
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ), (builder) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Container(
          height: MediaQuery.of(context).size.height / 1.4,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        // key: _formkey,
                        // child: Card(
                        child: Column(
                          children: [
                            otpTxt(),
                            otpSendTxt(),
                            passTxt(),
                            otpInputField(),
                            loginBtn()
                          ],
                        ),
                        // )
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  otpTxt() {
    return const Padding(
        padding:
            EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0, bottom: 20),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'OTP Verification',
            style: TextStyle(
              fontFamily: 'Arboria-Medium',
              fontSize: 32,
              letterSpacing: 0.46000000834465027,
              fontWeight: FontWeight.normal,
              color: Color.fromRGBO(29, 55, 84, 1),
              height: 1,
            ),
          ),
        ));
  }

  otpSendTxt() {
    return const Padding(
      padding: EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0, bottom: 20),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'We have sent otp to your mobile number',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(29, 55, 84, 0.699999988079071),
              fontFamily: 'Arboria-Light',
              fontSize: 16,
              letterSpacing: 0.46000000834465027,
              fontWeight: FontWeight.normal,
              height: 1),
        ),
      ),
    );
  }

  OtpFieldController otpController = OtpFieldController();

  Widget otpInputField() {
    return OTPTextField(
      controller: otpController,
      length: 4,
      width: MediaQuery.of(context).size.width,
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldWidth: 45,
      fieldStyle: FieldStyle.box,
      outlineBorderRadius: 12,
      otpFieldStyle: OtpFieldStyle(errorBorderColor: Colors.red //(here)
          ),
      style: TextStyle(fontSize: 17),
      onChanged: (pin) {
        print("Changed: " + pin);
      },
      onCompleted: (pin) {
        print("Completed: " + pin);
        _otp = pin;
      },
    );
    // Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Pinput(
    //     fieldsCount: 4,
    //     eachFieldHeight: 50.0,
    //     withCursor: true,
    //     onSubmit: (){},
    //     controller: _pinPutController2,
    //     submittedFieldDecoration: BoxDecoration(
    //       border: Border.all(color: Colors.black),
    //       borderRadius: BorderRadius.circular(15.0),
    //     ).copyWith(
    //       borderRadius: BorderRadius.circular(20.0),
    //     ),
    //     selectedFieldDecoration: BoxDecoration(
    //       color: Colors.green,
    //       border: Border.all(color: Colors.black),
    //       borderRadius: BorderRadius.circular(15.0),
    //     ),
    //     followingFieldDecoration: BoxDecoration(
    //       border: Border.all(color: Colors.black),
    //       borderRadius: BorderRadius.circular(15.0),
    //     ).copyWith(
    //       borderRadius: BorderRadius.circular(5.0),
    //       border: Border.all(
    //         color: Colors.black,
    //       ),
    //     ),
    //   ),
    // );
  }

  otpField() {
    return TextField(
      autofocus: true,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      controller: passwordController,
      maxLength: 1,
      cursorColor: Theme.of(context).primaryColor,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          counterText: '',
          hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        }
      },
    );
  }

  String? _otp;

  loginBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 135),
      child: InkWell(
        onTap: () => validateAndLogin(),
        child: Container(
          height: 42.0,
          width: MediaQuery.of(context).size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(122, 128, 190, 0.1599999964237213),
                  offset: Offset(0, 10),
                  blurRadius: 40)
            ],
            color: const Color.fromRGBO(29, 55, 84, 1),
            // gradient: LinearGradient(
            //     begin: Alignment.centerLeft,
            //     end: Alignment.centerRight,
            //     colors: [
            //       Color.fromARGB(255, 35, 63, 95),
            //       Color.fromRGBO(29, 55, 84, 1),
            //     ])),
          ),
          child: const Center(
            child: Text(
              "SUBMIT",
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Arboria-Medium',
                  fontSize: 15,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
          ),
        ),
      ),
    );
  }

  void validateAndLogin() async {
    final String mobileNo = nameController.text;
    var pass = _otp;
    print(pass);
    var url =
        "http://staging.ireckoner.com:3000/master/supplyPortLogin?ProfileId=92000067_Live&MobileNo=${mobileNo}&PortalPassword=${pass}";
    final response = await http.get(Uri.parse(url));

    var data = jsonDecode(response.body.toString());
    print(data);
    if (data[0]['data'].length != 0) {
      party.add(LoginData.fromJson(data[0]));
      print(party);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('PartyName', party[0].data[0].partyName.toString());
      prefs.setInt('PartyId', party[0].data[0].partyId.toInt());
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const Home(),
        ),
      );
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Incorrent credentials'),
          content: const Text('Mobile No. or Password is incorrect'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
