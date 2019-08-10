import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:avengers/core/enums/viewstate.dart';
import 'package:avengers/core/viewmodels/home_model.dart';
import 'package:avengers/ui/shared/fullscreen_photo.dart';
import 'package:avengers/ui/views/base_view.dart';
import 'package:avengers/ui/views/home/avengers_slide.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _heightFactorAnimation;
  double collapsedHeightFactor = 0.90;
  double expandedHeightFactor = 0.75;
  bool isAnimationCompleted = false;
  double screenHeight = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _heightFactorAnimation =
        Tween<double>(begin: collapsedHeightFactor, end: expandedHeightFactor)
            .animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  onBottomPartTap() {
    setState(() {
      if (isAnimationCompleted) {
        _controller.reverse();
      } else {
        _controller.forward();
      }

      isAnimationCompleted = !isAnimationCompleted;
    });
  }

  _handleOnVerticalDragUpdate(DragUpdateDetails updateDetails) {
    double fractionDragged = updateDetails.primaryDelta / screenHeight;
    _controller.value = _controller.value - 5 * fractionDragged;
  }

  _handleOnVerticalDragEnd(DragEndDetails dragEndDetails) {
    if (_controller.value >= 0.5) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize.height;

    return BaseView<HomeModel>(
        onModelReady: (model) => model.getAvengers(),
        builder: (context, model, child) {
          return Consumer<HomeModel>(
            builder: (context, model, child) {
              return model.state == ViewState.Busy
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF774EFF)),
                      ),
                    )
                  : Scaffold(
                      body: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, widget) {
                          return buildHomePage(model);
                        },
                      ),
                      backgroundColor: Color(0xFF242525),
                    );
            },
          );
        });
  }

  buildHomePage(model) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // this will detected a tap and open the photo in full screen
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (BuildContext context, _, __) => FullScreenPhoto(
                  imagePath: model.selectedAvenger.imagePath,
                  tag:
                      "fullscreen-photo-" + model.selectedAvenger.id.toString(),
                ),
              ),
            );
          },
          // this is a box with the slide of photos as a child
          child: FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: _heightFactorAnimation.value,
            child: AvengersSlide(),
          ),
        ),
        // this is that bottom box with the avenger's description
        GestureDetector(
          onTap: onBottomPartTap,
          onVerticalDragUpdate: _handleOnVerticalDragUpdate,
          onVerticalDragEnd: _handleOnVerticalDragEnd,
          child: buildAvengerDescription(model),
        )
      ],
    );
  }

  
  // avenger's description box
  FractionallySizedBox buildAvengerDescription(model) {
    return FractionallySizedBox(
      alignment: Alignment.bottomCenter,
      heightFactor: 1.06 - _heightFactorAnimation.value,
      child: Container(
        decoration: BoxDecoration(
          // color: Color(0xFF242525),
          gradient: LinearGradient(colors: [
            Color(0xFF242525),
            Color(0xFF2d2d2d),
            // Color(0XFF3E1C9F),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                model.selectedAvenger.name,
                style: TextStyle(
                  color: Color(0xFFDED9D0),
                  fontSize: 18,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Text(
                  model.selectedAvenger.description,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Color(0xFFDED9D0).withOpacity(0.8),
                    letterSpacing: .5,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
