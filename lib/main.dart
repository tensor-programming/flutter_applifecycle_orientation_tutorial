import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

void main() {
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.landscapeRight]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orientation and Lifecycle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<MyHomePage> with WidgetsBindingObserver {
  AppLifecycleState appLifecycleState;
  List<String> data;
  TextEditingController controller = TextEditingController();
  String getData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    data = [];
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        setState(() {
          controller.text.isNotEmpty ? data.add(controller.text) : null;
          controller.text = "";
        });
        break;
      case AppLifecycleState.resumed:
        setState(() {
          getData = data[0];
          data = [];
        });

        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Orientation and Lifecycle'),
        ),
        body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return Center(
              child: Column(children: [
                TextField(
                  controller: controller,
                ),
                Text(getData ?? ""),
              ]

                  // color: orientation == Orientation.landscape
                  //     ? Colors.amber
                  //     : Colors.purple,
                  // child: Text('App Life Cycle State $appLifecycleState'),
                  ),

              // GridView.count(
              //   crossAxisCount: orientation == Orientation.landscape ? 4 : 2,
              //   children: List.generate(40, (int i) {
              //     return Text("Tile $i");
              //   })
            );
          },
        ));
  }
}
