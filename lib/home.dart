// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'authentication/firebase_auth_service.dart';
import 'components/category_list_view.dart';
import 'components/course_detail_screen.dart';
import 'components/theme.dart';
import 'components/feature_course_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CategoryType categoryType = CategoryType.ui;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user1 => _auth.currentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomAppTheme.nearlyWhite,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("GoalTube"),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(user1!.displayName.toString()),
                accountEmail: Text(user1!.email.toString()),
                currentAccountPicture: user1.photoURL != null
                    ? ClipOval(
                        child: Material(
                          elevation: 2.0,
                          shadowColor: Colors.black,
                          color: Colors.grey.shade600,
                          child: Image.network(
                            user1.photoURL!,
                            width: 60.0,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      )
                    : ClipOval(
                        child: Material(
                          // color: CustomColors.firebaseGrey.withOpacity(0.3),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle_outlined),
                title: Text(user1.displayName),
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              // SizedBox(height: 1.0, child: Container(color: Colors.black38,),),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
              ),
              ListTile(
                  leading: Icon(Icons.add_sharp),
                  title: Text("Add Playlist"),
                  onTap: () {
                    Navigator.pushNamed(context, '/add');
                  }),
              ListTile(
                  leading: Icon(Icons.featured_play_list_outlined),
                  title: Text("My Playlist"),
                  onTap: () {
                    Navigator.pushNamed(context, '/myPlaylist');
                  }),
              ListTile(
                  leading: Icon(Icons.featured_play_list_outlined),
                  title: Text("All courses"),
                  onTap: () {
                    Navigator.pushNamed(context, '/allCourses');
                  }),
              ListTile(
                leading: Icon(Icons.account_box_outlined),
                title: Text("About Us"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/pdf_template');
                },
                leading: Icon(Icons.contact_support_outlined),
                title: Text("Contact Us"),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () {
                  setState(() {
                    FirebaseAuthService().signOutUser().then((result) {
                      Navigator.pushNamed(context, '/Splashview');
                    });
                  });
                },
              )
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      getSearchBarUI(),
                      getCategoryUI(),
                      Flexible(
                        child: getFeatureCourseUI(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'Category',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: CustomAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              getButtonUI(CategoryType.ui, categoryType == CategoryType.ui),
              const SizedBox(
                width: 16,
              ),
              getButtonUI(
                  CategoryType.coding, categoryType == CategoryType.coding),
              const SizedBox(
                width: 16,
              ),
              getButtonUI(
                  CategoryType.flutter, categoryType == CategoryType.flutter),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        CategoryListView(
          callBack: () {
            moveTo();
          },
        ),
      ],
    );
  }

  Widget getFeatureCourseUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Featured Courses',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: CustomAppTheme.darkerText,
            ),
          ),
          Flexible(
            child: FeatureCourseListView(
              callBack: () {
                moveTo();
              },
            ),
          )
        ],
      ),
    );
  }

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CourseDetailScreen(),
      ),
    );
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.ui == categoryTypeData) {
      txt = 'Ui/Ux';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = 'Coding';
    } else if (CategoryType.flutter == categoryTypeData) {
      txt = 'Flutter';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected
                ? CustomAppTheme.nearlyYoutubeRed
                : CustomAppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: CustomAppTheme.nearlyYoutubeRed)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? CustomAppTheme.nearlyWhite
                        : CustomAppTheme.nearlyYoutubeRed,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Container(
      margin: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      height: 64,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF0F0F0),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(13.0),
              bottomLeft: Radius.circular(13.0),
              topLeft: Radius.circular(13.0),
              topRight: Radius.circular(13.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: TextFormField(
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: CustomAppTheme.nearlyYoutubeRed,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Search for course',
                      border: InputBorder.none,
                      helperStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                height: 60,
                child: Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum CategoryType {
  ui,
  coding,
  flutter,
}
