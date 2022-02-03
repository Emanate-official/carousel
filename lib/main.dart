import 'package:carousel/carousel.dart';
import 'package:flutter/material.dart';
import 'package:refresh_list/loading_list.dart';
import 'dart:math' as math;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> images = [
    "https://wallpaperaccess.com/full/2637581.jpg",
    "https://wallpaperaccess.com/full/2637581.jpg",
    "https://wallpaperaccess.com/full/2637581.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top,
        ),
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              snap: false,
              floating: false,
              expandedHeight: 150,
              flexibleSpace: Carousel(
                children: List.generate(
                  images.length,
                  (int index) {
                    return Container(
                      margin: const EdgeInsets.all(0),
                      child: Image.network(
                        images[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverFillRemaining(
              child: RefreshList(
                builder: (int index) {
                  return Container(
                    margin: const EdgeInsets.all(2),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.red,
                  );
                },
                physics: CustomScrollPhysics(),
                length: 32,
                loadingIndicator: SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                ),
                onLoad: () async {},
                onRefresh: () async {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  CustomScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  bool isScrollingUp = false;

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    if (position.viewportDimension == 797) {
      return true;
    } else {
      return false;
    }
  }

  // @override
  // bool get allowImplicitScrolling => false;

  @override
  CustomScrollPhysics applyTo(ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    isScrollingUp = offset.sign < 0;
    return offset;
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      return value - position.pixels;
    }
    if (position.maxScrollExtent <= position.pixels &&
        position.pixels < value) {
      return value - position.pixels;
    }
    if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) {
      return value - position.minScrollExtent;
    }

    if (position.pixels < position.maxScrollExtent &&
        position.maxScrollExtent < value) {
      return value - position.maxScrollExtent;
    }
    return 0.0;
  }
}
