library carousel;

import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({
    Key? key,
    required this.children,
    this.initialPage = 0,
    this.onPageChange,
    this.padEnds = false,
    this.pageController,
    this.pageSnapping = true,
    this.viewportFraction = .95,
  }) : super(key: key);

  /// List of widgets to display in the carousel
  final List<Widget> children;

  /// Page to set as default
  final int initialPage;

  /// Callback function to run when the current page changes
  final Function(int)? onPageChange;

  /// Add additional padding to the ends of the carousel
  final bool padEnds;

  /// Controller to manage navigation
  final PageController? pageController;

  /// Snap to page when swipping
  final bool pageSnapping;

  /// Fraction of surrounding pages to display
  final double viewportFraction;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _controller;

  @override
  void initState() {
    // Create a new page controller if one is not provided
    _controller = widget.pageController ??
        PageController(
          initialPage: widget.initialPage,
          viewportFraction: widget.viewportFraction,
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: widget.children.length,
      padEnds: widget.padEnds,
      pageSnapping: widget.pageSnapping,
      onPageChanged: widget.onPageChange ?? (index) {},
      itemBuilder: (BuildContext context, int index) {
        return widget.children[index];
      },
    );
  }
}
