import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter_chat/src/widgets/appButton.dart';
import 'package:vector_math/vector_math.dart' as Vector;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class WelcomeScreen extends StatefulWidget {
  static const String routeName = "";
  @override
  _WelcomeScreenState createState() => new _WelcomeScreenState();

  WelcomeScreen() {
    timeDilation = 1.0;
  }
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void goToLogin() {
    Navigator.pushNamed(context, "/login");
  }

  Widget getButton(
      Color buttonColor, String buttonName, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Material(
          borderRadius: BorderRadius.circular(30.0),
          color: buttonColor,
          elevation: 5.0,
          child: SizedBox(
            width: 290.0,
            height: 43.0,
            child: FlatButton(
              child: Text(
                buttonName,
                style: TextStyle(color: Color.fromRGBO(247, 142, 30, 1)),
              ),
              onPressed: onPressed,
            ),
          )),
    );
  }

  void login() {
    print("login");
  }

  void register() {
    print("register");
  }

  @override
  Widget build(BuildContext context) {
    Size size = new Size(MediaQuery.of(context).size.width, 385.0);
    return new Scaffold(
        backgroundColor: Color.fromRGBO(250, 178, 85, 1),
        body: Container(
          child: Column(
            children: <Widget>[
              new Stack(
                children: <Widget>[
                  new ColorCurveBody(size: size, xOffset: 10, yOffset: -75),
                  new ColorCurveBody(
                      size: size,
                      xOffset: 10,
                      yOffset: 270,
                      color: Colors.white),
                  new ColorCurveBody(
                      size: size,
                      xOffset: 10,
                      yOffset: 280,
                      color: Color.fromRGBO(250, 178, 85, 1)),
                  Positioned(
                    top: 90,
                    left: (MediaQuery.of(context).size.width / 2) - 70,
                    child: Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 5),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("images/logoLogistic.png"))),
                    ),
                  ),
                ],
              ),
              Image.asset("images/logo.png"),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Aduanas App",
                        style: TextStyle(
                            fontSize: 40.0, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              AppButton(
                color: Colors.white,
                  invertColors: false,
                name: "Bienvenido",
                onPressed: goToLogin,
              )
            ],
          ),
        ));
  }
}

class ColorCurveBody extends StatefulWidget {
  final Size size;
  final int xOffset;
  final int yOffset;
  final Color color;

  ColorCurveBody(
      {Key key, @required this.size, this.xOffset, this.yOffset, this.color})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _ColorCurveBodyState();
  }
}

class _ColorCurveBodyState extends State<ColorCurveBody>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<Offset> animList1 = [];

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animationController.addListener(() {
      animList1.clear();
      for (int i = -2 - widget.xOffset;
          i <= widget.size.width.toInt() + 2;
          i++) {
        animList1.add(new Offset(
            i.toDouble() + widget.xOffset,
            sin((animationController.value * 360 - i) %
                        360 *
                        Vector.degrees2Radians) *
                    20 +
                50 +
                widget.yOffset));
      }
    });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Color.fromRGBO(255, 255, 255, 0.50),
      alignment: Alignment.center,
      child: new AnimatedBuilder(
        animation: new CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
        builder: (context, child) => new ClipPath(
          child: widget.color == null
              ? Image.asset(
                  'images/logo.png',
                  width: widget.size.width,
                  height: widget.size.height,
                  fit: BoxFit.cover,
                )
              : new Container(
                  width: widget.size.width,
                  height: widget.size.height,
                  color: widget.color,
                ),
          clipper: new WaveClipper(animationController.value, animList1),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animation;

  List<Offset> waveList1 = [];

  WaveClipper(this.animation, this.waveList1);

  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.addPolygon(waveList1, false);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      animation != oldClipper.animation;
}
