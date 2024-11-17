import 'package:flutter/material.dart';

import '../../../widgets/app_image.dart';

class AnimatedSplashChild extends StatefulWidget {
  final Function? next;
  final String imagePath;
  final int duration;
  final SplashScreenTypeConstants animationEffect;
  final BoxFit boxFit;
  final Size? size;

  const AnimatedSplashChild({
    super.key,
    required this.next,
    required this.imagePath,
    required this.animationEffect,
    this.duration = 1000,
    this.boxFit = BoxFit.contain,
    this.size,
  });

  @override
  State<StatefulWidget> createState() => __AnimatedSplashStateChild();
}

class __AnimatedSplashStateChild extends State<AnimatedSplashChild> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animationController.reset();
    _animationController.forward();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInCubic,
    ));
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 1500)).then(
          (value) {
            widget.next?.call();
          },
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.reset();
    _animationController.dispose();
  }

  Widget _buildAnimation(Size size) {
    switch (widget.animationEffect) {
      case SplashScreenTypeConstants.fadeIn:
        {
          return FadeTransition(
            opacity: _animation,
            child: Center(
              child: AppImage(
                imageUrl: widget.imagePath,
                fit: widget.boxFit,
                height: size.height,
                width: size.width,
              ),
            ),
          );
        }
      case SplashScreenTypeConstants.zoomIn:
        {
          return ScaleTransition(
            scale: _animation,
            child: AppImage(
              imageUrl: widget.imagePath,
              fit: widget.boxFit,
              height: size.height,
              width: size.width,
            ),
          );
        }
      case SplashScreenTypeConstants.zoomOut:
        {
          return ScaleTransition(
            scale: Tween(begin: 2.1, end: 1.0)
                .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInCirc)),
            child: AppImage(
              imageUrl: widget.imagePath,
              fit: widget.boxFit,
              height: size.height,
              width: size.width,
            ),
          );
        }
      case SplashScreenTypeConstants.topDown:
      default:
        {
          return SizeTransition(
            sizeFactor: _animation,
            child: AppImage(
              imageUrl: widget.imagePath,
              fit: widget.boxFit,
              height: size.height,
              width: size.width,
            ),
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final size = widget.size ?? Size(screenSize.width / 1.5, screenSize.height);
    return _buildAnimation(size);
  }
}

enum SplashScreenTypeConstants {
  fadeIn,
  zoomIn,
  zoomOut,
  topDown,
}
