// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:file_manager/catogory_screen/audio_screen.dart';
import 'package:file_manager/catogory_screen/document_screen.dart';
import 'package:file_manager/catogory_screen/image_screen.dart';
import 'package:file_manager/catogory_screen/video_screen.dart';
import 'package:file_manager/db/function.dart';
import 'package:file_manager/model/data_model.dart';
import 'package:file_manager/screens/recent_screen.dart';
import 'package:file_manager/widgets/category.dart';
import 'package:file_manager/widgets/containersearch.dart';
import 'package:file_manager/widgets/drawerpage.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(
          'EXPLORER',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
      ),

      //----------------------------drawer---------------------------------
      drawer: Drawer(
        elevation: 100,
        shadowColor: const Color.fromARGB(255, 227, 227, 226),
        child: Container(
          color: Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "settings",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Expanded(child: DrawerHeaderWidget()),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 1),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RecentScreen(),
                ));
              },
              child: searchcontainer(),
            ),
            SizedBox(height: 1),

            //--------------------------categoryscreens---------------------------------
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
                            containerText: "images",
                          ),
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
                            containerText: "videos",
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

                //--------------------------container(addes files)--------------------------
                Container(
                  height: 80,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 223, 219, 219),
                    border: Border.all(
                      width: 2,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "10  / 100",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("files added"),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                //------------------------row(recemtfile & see all)-------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text(
                        "Recent Files",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RecentScreen(),
                        ));
                      },
                      child: Text(
                        "see all",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Divider(),
            //------------------passfiles---------------------------------------
            Column(
              children: [
                ValueListenableBuilder<List<FileModel>>(
                  valueListenable: FileNotifier,
                  builder: (context, recentFiles, child) {
                    final limitedFiles = recentFiles.take(5).toList();
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: limitedFiles.length,
                          itemBuilder: (context, index) => Card(
                            elevation: 4,
                            child: GestureDetector(
                              onTap: () {
                                openFile(limitedFiles[index]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(),
                                  color: Color.fromARGB(208, 255, 147, 7),
                                ),
                                child: ListTile(
                                  title: Text(limitedFiles[index].fileName),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
