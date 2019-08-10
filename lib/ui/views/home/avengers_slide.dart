import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:avengers/core/viewmodels/home_model.dart';
import 'package:avengers/ui/shared/two_line.dart';
import 'package:snappable/snappable.dart';

class AvengersSlide extends StatefulWidget {
  final PageController _pageController = PageController(initialPage: 0);
  final double opacity = 0.2;

  @override
  _AvengersSlideState createState() => _AvengersSlideState();
}

class _AvengersSlideState extends State<AvengersSlide>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _slideAnimation;
  Animation _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    
    // this slide animation is used in the avenger's attributes
    _slideAnimation = TweenSequence([
      TweenSequenceItem<Offset>(
          weight: 10, tween: Tween(begin: Offset(0, 0), end: Offset(0, 1))),
      TweenSequenceItem<Offset>(
          weight: 90, tween: Tween(begin: Offset(0, 1), end: Offset(0, 0))),
    ]).animate(_controller);

    // this fade animation is used in the avenger's attributes
    _fadeAnimation = TweenSequence([
      TweenSequenceItem<double>(
        weight: 10,
        tween: Tween(begin: 1, end: 0),
      ),
      TweenSequenceItem<double>(
        weight: 90,
        tween: Tween(begin: 0, end: 1),
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = Provider.of<HomeModel>(context);

    return Stack(
      children: <Widget>[
        // this page PageView.builder will generate that slide of photos
        PageView.builder(
          itemCount: homeModel.avengers.length,
          controller: widget._pageController,
          pageSnapping: true,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index) {
            // when page changes, set the current avenger in the homeModel
            homeModel.selectAvenger(homeModel.avengers[index]);
            // this set state will run the animations
            this.setState(() {
              _controller.reset();
              _controller.forward();
            });
          },
          itemBuilder: (context, index) {
            return buildPhoto(homeModel, index);
          },
        ),
        // avenger attributes
        buildAvengerAttributes(homeModel)
      ],
    );
  }

  // some attributes of an avenger
  Positioned buildAvengerAttributes(HomeModel homeModel) {
    return Positioned(
        bottom: 60,
        left: 20,
        right: 20,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: <Widget>[
                Snappable(
                  snapOnTap: true,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TwoLineItem(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        firstText:
                            homeModel.selectedAvenger.strength.toString(),
                        secondText: "strength",
                      ),
                      TwoLineItem(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        firstText: homeModel.selectedAvenger.speed.toString(),
                        secondText: "speed",
                      ),
                      TwoLineItem(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        firstText: homeModel.selectedAvenger.agility.toString(),
                        secondText: "agility",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  // the photo in the slider
  Stack buildPhoto(HomeModel homeModel, int index) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // the photo
        Hero(
          tag: "fullscreen-photo-" + homeModel.avengers[index].id.toString(),
          child: Image.asset(
            homeModel.avengers[index].imagePath,
            fit: BoxFit.cover,
            // color: Colors.black,
            // colorBlendMode: BlendMode.hue,
          ),
        ),
        // that gradient effect in the photo
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(1),
                Colors.black.withOpacity(0.7),
                Colors.black.withOpacity(widget.opacity),
                Colors.white.withOpacity(widget.opacity),
                Colors.black.withOpacity(widget.opacity),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ],
    );
  }
}
