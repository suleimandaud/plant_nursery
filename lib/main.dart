// import 'package:flutter/material.dart';
// import 'screens/favorite_screen.dart';
// import 'screens/home_screen.dart';
// import 'screens/cart_screen.dart';
// import 'models/cart_model.dart';

// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;

//   static List<Widget> _widgetOptions = <Widget>[
//     Home(),
//     CartScreen(),
//     FavoriteScreen(),
//   ];
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green[100],
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: ValueListenableBuilder<int>(
//         valueListenable: CartModel.cartItemCount,
//         builder: (context, cartItemCount, child) {
//           return BottomNavigationBar(
//             backgroundColor: Color.fromARGB(255, 119, 208, 120),
//             items: <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Stack(
//                   children: [
//                     Icon(Icons.shopping_cart),
//                     if (cartItemCount > 0)
//                       Positioned(
//                         right: 0,
//                         child: Container(
//                           padding: EdgeInsets.all(1),
//                           decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           constraints: BoxConstraints(
//                             minWidth: 12,
//                             minHeight: 12,
//                           ),
//                           child: Text(
//                             '$cartItemCount',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 8,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//                 label: 'Cart',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.favorite),
//                 label: 'Favorites',
//               ),
//             ],
//             currentIndex: _selectedIndex,
//             selectedItemColor: const Color.fromARGB(255, 227, 241, 227),
//             onTap: _onItemTapped,
//           );
//         },
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     title: 'Plant Nursery',
//     theme: ThemeData(
//       primarySwatch: Colors.green,
//     ),
//     debugShowCheckedModeBanner: false,
//     home: MainScreen(),
//   ));
// }

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:plant_nursery/screens/loginC.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: _initialization,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return MaterialApp(
//               home: Scaffold(
//                 body: Center(
//                   child: Text("waiting.........."),
//                 ),
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return MaterialApp(
//               home: Scaffold(
//                 body: Center(
//                   child: Text("there was an error"),
//                 ),
//               ),
//             );
//           }

//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'my app',
//             theme: ThemeData(
//               scaffoldBackgroundColor: Colors.black,
//               primarySwatch: Colors.blue,
//             ),
//             home: LoginTest(),
//           );
//         });
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plant_nursery/screens/loginC.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    // Initialize Firebase with manual configuration for web
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyATOuxGopRys5nJD-U42wjFFv5jR12ot0Y",
          authDomain: "testplant-67122.firebaseapp.com",
          projectId: "testplant-67122",
          storageBucket: "testplant-67122.appspot.com",
          messagingSenderId: "399168321034",
          appId: "1:399168321034:web:4cbd7aa6699782fd3491f3",
          measurementId: "G-8GGJ66524S"),
    );
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'my app',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
      ),
      home: LoginTest(),
    );
  }
}
