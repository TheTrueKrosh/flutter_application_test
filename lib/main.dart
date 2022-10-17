import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:bottom_nav_bar/bottom_nav_bar.dart';
import 'package:flutter_application_test/card_screen/card_screen.dart';
import 'package:flutter_application_test/catalog_screen/catalog_screen.dart';
import 'package:flutter_application_test/profile/profile_screen.dart';
import 'package:flutter_application_test/start_screen/start_screen.dart';
import 'package:scrollable_reorderable_navbar/scrollable_reorderable_navbar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

Future<void> backroundHandler(RemoteMessage message) async {
  print(" This is message from background");
  print(message.notification!.title);
  print(message.notification!.body);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backroundHandler);
  final token = await FirebaseMessaging.instance.getToken();
  print(token);
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
        primarySwatch: Colors.blue,
      ),
      // home: const MainScreen(title: 'Flutter Demo Home Page'),
      home: const StartScreenWidget(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  String notificationMsg = "В ожидании оповещалок....";

  @override
  void initState() {
    super.initState();
    // LocalNotificationService.initilize();
    // Terminated State
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        setState(() {
          notificationMsg =
              "${event.notification!.title} ${event.notification!.body} I am coming from terminated state";
        });
      }
    });

    // Foregrand State
    FirebaseMessaging.onMessage.listen((event) {
      // LocalNotificationService.showNotificationOnForeground(event);
      setState(() {
        notificationMsg =
            "${event.notification!.title} ${event.notification!.body} I am coming from foreground";
      });
    });

    // background State
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      setState(() {
        notificationMsg =
            "${event.notification!.title} ${event.notification!.body} I am coming from background";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  Widget _body() => SizedBox.expand(
        child: IndexedStack(
          index: _currentIndex,
          children: <Widget>[
            CardScreenWidget(
              notificationMsg: notificationMsg,
            ),
            const CatalogScreenWidget(),
            const PageThree(),
            const ProfileScreenWidget(),
          ],
        ),
      );
  Widget _bottomNavBar() => BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(
          () {
            _currentIndex = index;
            // _pageController.animateToPage(index,
            //     duration: Duration(milliseconds: 300), curve: Curves.ease);
          },
        ),
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Магазин'),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.shopping_cart),
              title: const Text('Каталог'),
              activeColor: Colors.blue),
          BottomNavyBarItem(
              icon: const Icon(Icons.chat_bubble),
              title: const Text('Сообщения'),
              activeColor: Colors.blue),
          BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Профиль'),
              activeColor: Colors.blue),
        ],
      );
  // BottomNavBar(
  //       showElevation: true,
  //       selectedIndex: _currentIndex,
  //       onItemSelected: (index) {
  //         setState(() => _currentIndex = index);
  //       },
  //       items: <BottomNavBarItem>[
  //         BottomNavBarItem(
  //           title: 'Магазин',
  //           icon: const Icon(Icons.home),
  //           activeColor: Colors.white,
  //           inactiveColor: Colors.black,
  //           activeBackgroundColor: Colors.red.shade300,
  //         ),
  //         BottomNavBarItem(
  //           title: 'Каталог',
  //           icon: const Icon(Icons.shopping_cart),
  //           inactiveColor: Colors.black,
  //           activeColor: Colors.black,
  //           activeBackgroundColor: Colors.yellow.shade300,
  //         ),
  //         BottomNavBarItem(
  //           title: 'Сообщения',
  //           icon: const Icon(Icons.chat_bubble),
  //           inactiveColor: Colors.black,
  //           activeColor: Colors.white,
  //           activeBackgroundColor: Colors.green.shade300,
  //         ),
  //         BottomNavBarItem(
  //           title: 'Профиль',
  //           icon: const Icon(Icons.person),
  //           activeColor: Colors.white,
  //           inactiveColor: Colors.black,
  //           activeBackgroundColor: Colors.blue.shade300,
  //         ),
  //       ],
  //     );
}

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Page 1'));
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Page 2'));
  }
}

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Page 3'));
  }
}

class PageFour extends StatelessWidget {
  const PageFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Page 4'));
  }
}
