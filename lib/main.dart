// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:goaltube/components/forms/requestplaylist_data.dart';
import 'package:goaltube/components/my_playlists.dart';
import 'package:goaltube/home.dart';
import 'package:goaltube/user_profile.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'authentication/authPage.dart';
import 'authentication/firebase_auth_service.dart';
import 'basicTheme.dart';
import 'components/all_courses.dart';
import 'components/forms/requestplaylist_data.dart';
import 'onboarding_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  await FlutterDownloader.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(create: (_) => FirebaseAuthService()),
        FutureProvider<Map<String, dynamic>?>(
          create: (context) async {
            var user = Provider.of<FirebaseAuthService>(context, listen: false)
                .currentUser();
            var userDoc = await FirebaseFirestore.instance
                .collection("Users")
                .doc(user!.email)
                .get();
            return userDoc.data();
          },
          initialData: {},
        ),
      ],
      child: GetMaterialApp(
        routes: {
          "/home": (context) => HomePage(),
          "/add": (context) => PlaylistForm(),
          "/onboard": (context) => OnboardingScreen(),
          "/profile": (context) => UserProfile(),
          "/myPlaylist": (context) => MyPlaylistView(),
          "/allCourses": (context) => AllCourses(),
        },
        debugShowCheckedModeBanner: false,
        title: 'GoalTube',
        theme: basicTheme(),
        home: AuthPage(),
      ),
    );
  }
}
