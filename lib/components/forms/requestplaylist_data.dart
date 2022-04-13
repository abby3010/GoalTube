// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors

import 'package:goaltube/authentication/firebase_auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

class PlaylistForm extends StatefulWidget {
  const PlaylistForm({Key? key}) : super(key: key);

  @override
  _PlaylistFormState createState() => _PlaylistFormState();
}

class _PlaylistFormState extends State<PlaylistForm> {
  var uuid = Uuid();
  bool isLoading = false;
  bool pre = false;
  TextEditingController Course_name = TextEditingController();

  TextEditingController course_playlist = TextEditingController();
  TextEditingController course_category = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
          "Add PlayList",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28, right: 28),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Course Name',
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFFF0000)),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFFF0000)),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: 'Enter Course Name',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  controller: Course_name,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Course Name is Required';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28, right: 28),
                child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Course Playlist',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFFF0000)),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFFF0000)),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      hintText: 'Enter Course Playlist Link',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    controller: course_playlist,
                    validator: (String? value) {
                      // Pattern pattern = r'^(https|http):\/\/(?:www\.)?youtube\.com\/watch\?(?:&.*)*((?:v=([a-zA-Z0-9_\-]{11})(?:&.**list=([a-zA-Z0-9_\-]{18})(?:&.*)*&v=([a-zA-Z0-9_\-]{11}))(?:&.*)*(?:\#.*)*$';
                      // RegExp regex = value!.contains(RegExp(pattern.toString()));

                      if (value!.isEmpty) {
                        return 'Youtube Link is Required';
                      } else if (!value.contains(RegExp(
                          r'^https?:\/\/(www.youtube.com|youtube.com|youtu.be)(.*)$'))) {
                        return 'Enter Valid url';
                      }
                      return null;
                    }),
              ),
              SizedBox(
                height: 15,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 28, right: 28),
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //       labelText: 'Course Category',
              //       labelStyle:TextStyle(color:Theme.of(context).primaryColor),
              //       focusColor:Theme.of(context).primaryColor,
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: const BorderSide(color: Colors.grey),
              //         borderRadius: BorderRadius.circular(25.0),
              //       ),
              //       focusedBorder:OutlineInputBorder(
              //         borderSide: const BorderSide(color: Color(0xFFffffff)),
              //         borderRadius: BorderRadius.circular(25.0),
              //       ),
              //       border: OutlineInputBorder(
              //         borderSide: const BorderSide(color: Color(0xFFFF0000)),
              //         borderRadius: BorderRadius.circular(25.0),
              //       ),
              //       hintText: 'Enter Course Category',
              //       hintStyle: TextStyle(color: Colors.grey),
              //     ),
              //     controller: course_category,
              //     validator: (String? value) {
              //       if (value!.isEmpty) {
              //         return 'Course Category is Required';
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),

              // isLoading ?
              // Container(child: CircularProgressIndicator(),): null,

              InkWell(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    var youtubeData =
                        await fetchPlaylistData(course_playlist.text);

                    var data = {
                      "courseName": Course_name.text,
                      "coursePlaylist": course_playlist.text,
                      // "courseCatogery": course_category.text,
                      "user_email": user?.email,
                      "uid": user?.uid,
                      "videos_data": youtubeData,
                      "isApproved": false
                    };

                    await FirebaseFirestore.instance
                        .collection("Courses")
                        .doc(uuid.v1())
                        .set(data)
                        .then((value) async {
                      await FirebaseFirestore.instance
                          .collection("Users")
                          .doc(user?.email)
                          .update({
                        "courses": FieldValue.arrayUnion([data])
                      }).then((value) {
                        setState(() {
                          pre = true;
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/myPlaylist", (route) => false);
                        });
                      });
                    }).catchError(
                            (error) {
                              if (kDebugMode) {
                                print("Failed to add document: $error");
                              }
                            });
                  }
                },
                child: AnimatedContainer(
                  height: 40,
                  duration: Duration(seconds: 1),
                  width: pre ? 55 : 110,
                  alignment: Alignment.center,
                  child: pre
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(pre ? 40 : 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future fetchPlaylistData(String playlistUrl) async {
  try {
    final urlRegExp = RegExp("[&?]list=([^&]+)");
    final urlMatches = urlRegExp.allMatches(playlistUrl);
    List<String> urls = urlMatches
        .map((urlMatch) => playlistUrl.substring(urlMatch.start, urlMatch.end))
        .toList();
    var id = urls[0].substring(6);
    final response = await http.get(Uri.parse(
        'https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=$id&key=AIzaSyD4lNZT4RlulSCjkoPzXcx6dV1M35wmhDQ'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Map> videosData = [];
      var data = jsonDecode(response.body);
      List items = data["items"];

      for (int i = 0; i < items.length; i++) {
        var snippet = items[i]["snippet"];
        videosData.add({
          "title": snippet["title"],
          "videoId": snippet["resourceId"]["videoId"],
          "channelName": snippet["videoOwnerChannelTitle"],
          "thumbnailLink": snippet["thumbnails"]["default"]["url"],
        });
      }
      return videosData;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (error) {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}
