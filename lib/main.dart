import 'package:carousel/carousel.dart';
import 'package:flutter/material.dart';
import 'package:refresh_list/sliver_list.dart';

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
  int length = 15;
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
        child: Column(
          children: [
            Expanded(
              child: SliverLoadingList(
                loadingIndicatorOffset: 255,
                loadingIndicator: SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(2),
                    color: Colors.blue,
                  ),
                ),
                onLoad: () async {
                  await Future.delayed(const Duration(seconds: 3));
                  setState(() {
                    length += 5;
                  });
                },
                onRefresh: () async {
                  setState(() {
                    length = 0;
                  });
                  Future.delayed(const Duration(seconds: 5), () async {
                    setState(() {
                      length = 10;
                    });
                  });
                },
                sliverBars: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
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
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    pinned: true,
                    primary: false,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 100,
                          color: Colors.green,
                        ),
                        Container(
                          height: 50,
                          width: 100,
                          color: Colors.green,
                        ),
                        Container(
                          height: 50,
                          width: 100,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ],
                length: length,
                builder: (int index) {
                  return SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
