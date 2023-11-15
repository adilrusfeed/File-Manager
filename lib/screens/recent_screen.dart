// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
  bool isGridView = false; // Default view mode is ListView
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
                          SizedBox(width: 10),
                          Text("Grid View")
                        ],
                      )),
                  PopupMenuItem<String>(
                      value: 'listView',
                      child: Row(
                        children: [
                          Icon(Icons.list),
                          SizedBox(width: 10),
                          Text("List View")
                        ],
                      )),
                  PopupMenuItem<String>(
                      value: 'sort',
                      child: Row(
                        children: [
                          Icon(Icons.sort),
                          SizedBox(width: 10),
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
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Divider(),
            Expanded(
              child: isGridView ? buildGridView() : buildListView(),
            )
          ],
        ));
  }

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
        // Reverse the list (newly added item come top)
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
            return ListTile(
                onTap: () {
                  openFile(file);
                },
                title: Text(file.fileName),
                leading: Icon(Icons.insert_drive_file),
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
                        child: Text('Delete'),
                      ),
                    ];
                  },
                ));
          },
        );
      },
    );
  }

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
                        Icon(Icons.insert_drive_file),
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
              onPressed: () {
                Navigator.of(context).pop();
                String newName = textController.text;
                if (newName.isNotEmpty) {
                  String newFileName =
                      newName + "." + file.fileName.split('.').last;

                  file.fileName = newFileName;

                  FileNotifier.value = FileNotifier.value
                      .map((f) => f.id == file.id ? file : f)
                      .toList();
                }
              },
            )
          ],
        );
      },
    );
  }
}
