// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:file_manager/catogory_screen/audio_screen.dart';
import 'package:file_manager/catogory_screen/document.dart';
import 'package:file_manager/catogory_screen/image_screen.dart';
import 'package:file_manager/catogory_screen/video_screen.dart';
import 'package:file_manager/screens/recent_screen.dart';
import 'package:file_manager/setting_page/about.dart';
import 'package:file_manager/setting_page/terms.dart';
import 'package:file_manager/widgets/category.dart';
import 'package:file_manager/widgets/drawer.dart';
import 'package:file_manager/widgets/search.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'FILE MANAGER',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        elevation: 100,
        shadowColor: const Color.fromARGB(255, 227, 227, 226),
        child: Container(
          color: Color(0xFFFFFFFF),
          child: ListView(children: [
            ListTile(
              title: Center(
                child: Text("Settings",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              ),
            ),
            SizedBox(height: 150),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AboutScreen(),
                  ));
                },
                child: DrawerItem(text: "about", icon: Icons.info)),
            Divider(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TermsScreen(),
                ));
              },
              child: DrawerItem(
                  text: "terms and conditions",
                  icon: Icons.document_scanner_rounded),
            ),
            Divider(),
            DrawerItem(text: "reset", icon: Icons.restore_from_trash_outlined),
            Divider(),
            DrawerItem(text: "exit", icon: Icons.exit_to_app),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 60),
              child: Text(
                "             version : 1.0.1",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ]),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 1),
            searchbar(),
            SizedBox(height: 1),
            Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 30),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ImageScreen(),
                            ));
                          },
                          child: categoryContainer(
                              imagePath: "assets/images/image.png",
                              containerText: "images"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => VideoScreen(),
                            ));
                          },
                          child: categoryContainer(
                            imagePath: "assets/images/video.png",
                            containerText: "gallery",
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AudioScreen(),
                            ));
                          },
                          child: categoryContainer(
                            imagePath: "assets/images/music.png",
                            containerText: "audio",
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DocumentScreen(),
                            ));
                          },
                          child: categoryContainer(
                            imagePath: "assets/images/document.png",
                            containerText: "documents",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 85,
                  width: 325,
                  decoration: BoxDecoration(
                    color: Color(0xFFF0ECEC),
                    border: Border.all(width: 2, color: Colors.grey[700]!),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "10 GB / 64 GB",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text("used storage"),
                      ],
                    ),
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text(
                        "Recent Files",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RecentScreen(),
                            ));
                          },
                          child: Text("see all")),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  recent(img: "assets/images/taj.jpeg", txt: "tajmahal"),
                  SizedBox(height: 2),
                  recent(img: "assets/images/taj.jpeg", txt: "tajmahal"),
                  SizedBox(height: 2),
                  recent(img: "assets/images/taj.jpeg", txt: "tajmahal"),
                  SizedBox(height: 2),
                  recent(img: "assets/images/taj.jpeg", txt: "tajmahal"),
                  SizedBox(height: 2),
                  recent(img: "assets/images/taj.jpeg", txt: "tajmahal"),
                  SizedBox(height: 2),
                  recent(img: "assets/images/taj.jpeg", txt: "tajmahal"),
                  SizedBox(height: 2),
                  recent(img: "assets/images/taj.jpeg", txt: "tajmahal"),
                  SizedBox(height: 2),
                  recent(img: "assets/images/taj.jpeg", txt: "tajmahal"),
                  SizedBox(height: 2),
                  recent(img: "assets/images/taj.jpeg", txt: "tajmahal"),
                  SizedBox(height: 2),
                  recent(img: "assets/images/taj.jpeg", txt: "tajmahal"),
                  SizedBox(height: 2),
                  recent(img: "assets/images/taj.jpeg", txt: "tajmahal"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container recent({required String img, required String txt}) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: Color(0xFFE8E6E6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                img,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  txt,
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
