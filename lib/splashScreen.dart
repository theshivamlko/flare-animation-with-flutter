import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<Homepage>
    with SingleTickerProviderStateMixin, FlareController {
  AnimationController controllerProgress;
  Animation<double> animation;
  double _rockAmount = 0.5;
  double _speed = 1.0;
  double _rockTime = 0.0;
  ActorAnimation _rock;

  @override
  void initialize(FlutterActorArtboard artboard) {
    _rock = artboard.getAnimation("music_walk");
  }

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    _rockTime += elapsed * _speed;
    _rock.apply(_rockTime % _rock.duration, artboard, _rockAmount);
    return true;
  }

  _controlProgrgress() {
    controllerProgress =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controllerProgress)
      ..addListener(() {
        setState(() {
          _speed = animation.value * 5;
        });
      });
    controllerProgress.repeat();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controlProgrgress();
  }

  @override
  Widget build(BuildContext context) {
    return splashPage();
  }

  Widget splashPage() {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
              child: FlareActor(
            "assets/Penguin.flr",
            alignment: Alignment.center,
            fit: BoxFit.cover,
            animation: "walk",
            controller: this,
          )),
          Positioned.fill(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                LinearProgressIndicator(
                  value: animation.value,
                ),
              ])),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controllerProgress.dispose();
    super.dispose();
  }

  @override
  void setViewTransform(Mat2D viewTransform) {
    // TODO: implement setViewTransform
  }
}
