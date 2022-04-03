// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:goaltube/authentication/firebase_auth_service.dart';
import 'package:goaltube/models/category.dart';
import 'package:goaltube/models/user.dart';
import 'dart:developer' as developer;
import 'all_courses.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class MyPlaylistView extends StatefulWidget {
  const MyPlaylistView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;
  @override
  _MyPlaylistViewState createState() => _MyPlaylistViewState();
}

class _MyPlaylistViewState extends State<MyPlaylistView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<List<Map<String, dynamic>>> getData(UserModel user) async {
    var userDoc = await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.email)
        .get();
    var userData = userDoc.data();
    var courses = userData!["courses"];
    developer.log(courses);
    return courses;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseAuthService>(context).currentUser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          tooltip: 'Back',
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        centerTitle: true,
        title: Text(
          "My Courses",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: FutureBuilder(
          future: getData(user!),
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            // developer.log("sd",  snapshot.data);
            if (snapshot.hasData) {
              developer.log("Hey there ========");
              var course = snapshot.data;
              var coursesList = Category().createCategoryList(course!);
              developer.log(
                "Hey there ========",
              );
              return GridView(
                padding: const EdgeInsets.all(8),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: List<Widget>.generate(
                  course.length,
                  (int index) {
                    final int? count = coursesList.length;
                    final Animation<double> animation =
                        Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animationController!,
                        curve: Interval((1 / count!) * index, 1.0,
                            curve: Curves.fastOutSlowIn),
                      ),
                    );
                    animationController?.forward();
                    return CategoryView(
                      callback: widget.callBack,
                      category: coursesList[index],
                      animation: animation,
                      animationController: animationController,
                    );
                  },
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 27.0,
                  crossAxisSpacing: 27.0,
                  childAspectRatio: 0.8,
                ),
              );
            } else if (snapshot.hasError) {
              developer.log("Hey there ========", error: snapshot.error);
              return Center(
                child: Text("Something went wrong!"),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

// class CategoryView extends StatelessWidget {
//   const CategoryView(
//       {Key? key,
//       this.category,
//       this.animationController,
//       this.animation,
//       this.callback})
//       : super(key: key);
//
//   final VoidCallback? callback;
//   final Category? category;
//   final AnimationController? animationController;
//   final Animation<double>? animation;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animationController!,
//       builder: (BuildContext context, Widget? child) {
//         return FadeTransition(
//           opacity: animation!,
//           child: Transform(
//             transform: Matrix4.translationValues(
//                 0.0, 50 * (1.0 - animation!.value), 0.0),
//             child: InkWell(
//               splashColor: Colors.transparent,
//               onTap: callback,
//               child: SizedBox(
//                 height: 280,
//                 child: Stack(
//                   alignment: AlignmentDirectional.bottomCenter,
//                   children: <Widget>[
//                     Container(
//                       child: Column(
//                         children: <Widget>[
//                           Expanded(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFF8FAFB),
//                                 borderRadius: const BorderRadius.all(
//                                     Radius.circular(16.0)),
//                                 // border: new Border.all(
//                                 //     color: CustomAppTheme.notWhite),
//                               ),
//                               child: Column(
//                                 children: <Widget>[
//                                   Expanded(
//                                     child: Container(
//                                       child: Column(
//                                         children: <Widget>[
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 top: 16, left: 16, right: 16),
//                                             child: Text(
//                                               category!.title,
//                                               textAlign: TextAlign.left,
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize: 16,
//                                                 letterSpacing: 0.27,
//                                                 color:
//                                                     CustomAppTheme.darkerText,
//                                               ),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 top: 8,
//                                                 left: 16,
//                                                 right: 16,
//                                                 bottom: 8),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               children: <Widget>[
//                                                 Text(
//                                                   '${category!.lessonCount} lesson',
//                                                   textAlign: TextAlign.left,
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.w200,
//                                                     fontSize: 12,
//                                                     letterSpacing: 0.27,
//                                                     color: CustomAppTheme.grey,
//                                                   ),
//                                                 ),
//                                                 Container(
//                                                   child: Row(
//                                                     children: <Widget>[
//                                                       Text(
//                                                         '${category!.rating}',
//                                                         textAlign:
//                                                             TextAlign.left,
//                                                         style: TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.w200,
//                                                           fontSize: 18,
//                                                           letterSpacing: 0.27,
//                                                           color: CustomAppTheme
//                                                               .grey,
//                                                         ),
//                                                       ),
//                                                       Icon(
//                                                         Icons.star,
//                                                         color: CustomAppTheme
//                                                             .nearlyYoutubeRed,
//                                                         size: 20,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     width: 48,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 48,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       child: Padding(
//                         padding:
//                             const EdgeInsets.only(top: 24, right: 16, left: 16),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(16.0)),
//                             boxShadow: <BoxShadow>[
//                               BoxShadow(
//                                   color: CustomAppTheme.grey.withOpacity(0.2),
//                                   offset: const Offset(0.0, 0.0),
//                                   blurRadius: 6.0),
//                             ],
//                           ),
//                           child: ClipRRect(
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(16.0)),
//                             child: AspectRatio(
//                               aspectRatio: 1.28,
//                               child: Image.asset(category!.imagePath),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
