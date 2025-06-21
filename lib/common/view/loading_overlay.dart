import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

class LoadingOverlay extends StatefulWidget {
  final bool isLoading;
  final double opacity;
  final Color? color;
  final Widget progressIndicator;
  final Widget child;
  final bool addBlur;

  LoadingOverlay({
    required this.isLoading,
    required this.child,
    required this.addBlur,
    this.opacity = 0.5,
    this.progressIndicator = const CircularProgressIndicator(),
    this.color,
  });

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool? _overlayVisible;

  _LoadingOverlayState();

  @override
  void initState() {
    super.initState();
    _overlayVisible = false;
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      // ignore: unnecessary_statements
      status == AnimationStatus.forward ? setState(() => {_overlayVisible = true}) : null;
      // ignore: unnecessary_statements
      status == AnimationStatus.dismissed ? setState(() => {_overlayVisible = false}) : null;
    });
    if (widget.isLoading) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(LoadingOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isLoading && widget.isLoading) {
      _controller.forward();
    }

    if (oldWidget.isLoading && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          widget.child,
          widget.isLoading ?
          Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: (widget.addBlur) ? Blur(
                  blur: 2,
                  blurColor: Colors.transparent,
                  child: buildFadeTransitionIndicator(),
                  overlay: Center(child: widget.progressIndicator)) : buildFadeTransitionIndicator()) : SizedBox.shrink()

        ]);
  }

  Widget buildFadeTransitionIndicator(){
    return FadeTransition(
      opacity: _animation,
      child: Stack(
        children: <Widget>[
          Opacity(
            child: ModalBarrier(
              dismissible: false,
              color: widget.color ?? Theme.of(context).colorScheme.background,
            ),
            opacity: widget.opacity,
          ),
          Center(child: widget.progressIndicator),
        ],
      ),
    );
  }
}