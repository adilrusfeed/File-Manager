// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:file_manager/model/data_model.dart';
import 'package:file_manager/db/function.dart';

class RecentScreen extends StatefulWidget {
  RecentScreen({Key? key}) : super(key: key);

  @override
  _RecentScreenState createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  TextEditingController searchController = TextEditingController();

  // -------------Default view mode is ListView --------------------------
  bool isGridView = false;
  bool isSorted = false;
  String searchQuery = "";

  void onSearchTextChanged(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  void initState() {
    getAlldata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Text(
            'All files',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),

          //-------------------------------------popup menu-----------------------------------
          actions: [
            PopupMenuButton<String>(
              onSelected: (choice) {
                setState(() {
                  if (choice == 'gridView') {
                    isGridView = true;
                  } else if (choice == 'listView') {
                    isGridView = false;
                  } else if (choice == 'sort') {
                    isSorted = !isSorted;
                  }
                });
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                      value: 'gridView',
                      child: Row(
                        children: [
                          Icon(Icons.grid_view),
                          SizedBox(width: 13),
                          Text("Grid View")
                        ],
                      )),
                  PopupMenuItem<String>(
                      value: 'listView',
                      child: Row(
                        children: [
                          Icon(Icons.list),
                          SizedBox(width: 13),
                          Text("List View")
                        ],
                      )),
                  PopupMenuItem<String>(
                      value: 'sort',
                      child: Row(
                        children: [
                          Icon(Icons.sort),
                          SizedBox(width: 13),
                          Text("Sort")
                        ],
                      )),
                ];
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: searchController,
                onChanged: onSearchTextChanged,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 236, 236),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    hintText: 'Search Files',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 192, 187, 187),
                        fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
            Divider(),
            Expanded(
              child: isGridView ? buildGridView() : buildListView(),
            )
          ],
        ));
  }

//-------------------------------------------listview-------------------------------------------
  Widget buildListView() {
    return ValueListenableBuilder<List<FileModel>>(
      valueListenable: FileNotifier,
      builder: (context, files, child) {
        if (isSorted) {
          files.sort((a, b) {
            return isSorted
                ? b.fileName.compareTo(a.fileName)
                : a.fileName.compareTo(b.fileName);
          });
        }

        files = files.reversed.toList();

        if (searchQuery.isNotEmpty) {
          files = files
              .where((file) => file.fileName
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
              .toList();
        }

        return ListView.builder(
          itemCount: files.length,
          itemBuilder: (context, index) {
            final file = files[index];
            return Padding(
                padding: EdgeInsets.symmetric(vertical: 1),
                child: Container(
                    color: index % 2 == 0
                        ? Color.fromARGB(255, 235, 237, 137)
                        : Color.fromARGB(255, 216, 216, 167),
                    child: ListTile(
                        onTap: () {
                          openFile(file);
                        },
                        title: Text(file.fileName),
                        leading: Icon(Icons.file_copy),
                        trailing: PopupMenuButton<String>(
                          onSelected: (choice) {
                            if (choice == "rename") {
                              setState(() {
                                renameFile(file);
                              });
                            } else if (choice == "delete") {
                              deleteFile(file);
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                value: 'rename',
                                child: Text('Rename'),
                              ),
                              PopupMenuItem<String>(
                                value: 'delete',
                                child: Text("Delete"),
                              ),
                            ];
                          },
                        ))));
          },
        );
      },
    );
  }

//----------------------------gridview--------------------------
  Widget buildGridView() {
    return ValueListenableBuilder<List<FileModel>>(
      valueListenable: FileNotifier,
      builder: (context, files, child) {
        if (isSorted) {
          files.sort((a, b) => b.fileName.compareTo(a.fileName));
        }
        files = files.reversed.toList(); // Reverse the list

        if (searchQuery.isNotEmpty) {
          files = files
              .where((file) => file.fileName
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
              .toList();
        }

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: files.length,
          itemBuilder: (context, index) {
            final file = files[index];
            return GestureDetector(
              onTap: () {
                openFile(file);
              },
              child: Card(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.file_copy_rounded),
                        Text(file.fileName),
                      ],
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: PopupMenuButton<String>(
                          onSelected: (choice) {
                            if (choice == "rename") {
                              renameFile(file);
                            } else if (choice == "delete") {
                              deleteFile(file);
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                value: 'rename',
                                child: Text('Rename'),
                              ),
                              PopupMenuItem<String>(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ];
                          },
                        )),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  //---------------------------rename method--------------------------
  void renameFile(FileModel file) async {
    TextEditingController textController = TextEditingController();
    String initialName = file.fileName.split('.').first;
    textController.text = initialName;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Rename file"),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(labelText: "New name"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              child: Text("Rename"),
              onPressed: () async {
                Navigator.of(context).pop();
                String newName = textController.text;
                if (newName.isNotEmpty) {
                  String newFileName =
                      newName + "." + file.fileName.split('.').last;

                  file.fileName = newFileName;
                  await renameFile1(
                    FileNotifier.value
                        .indexWhere((eachfile) => eachfile.id == file.id),
                    file,
                  );
                }
              },
            )
          ],
        );
      },
    );
  }
}
