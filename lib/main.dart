import 'package:flutter/material.dart';
import 'walkingPage.dart';
import 'availablePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex =0;



  @override
  Widget build(BuildContext context) {
    Widget page;
      switch (selectedIndex) {
        case 0:
          page = const Availablepage();
        case 1:
          page = const Walkingpage();
        default:
          throw UnimplementedError('no widget for $selectedIndex');
      }
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index){
              setState(() {
                selectedIndex = index;
              });
            },
            selectedIndex: selectedIndex,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.people_alt), // Icon for Users.
                label: 'Users',
              ),
              NavigationDestination(
                icon: Icon(IconData(0xe1e1, fontFamily: 'MaterialIcons')),
                label: "Start Walk")
            ],
          ),
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: page),
                ),
               ],
            ),
          ),
        );
      }
    );
  }
}
