// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, library_private_types_in_public_api, prefer_const_constructors_in_immutables, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:file_manager/model/data_model.dart';
import 'package:file_manager/db/function.dart';
import 'package:lottie/lottie.dart';

class RecentScreen extends StatefulWidget {
  RecentScreen({Key? key}) : super(key: key);

  @override
  _RecentScreenState createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  TextEditingController searchController = TextEditingController();

  // -------------Default view mode is gridView --------------------------
  bool isListView = true;
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
    List<FileModel> files = FileNotifier.value;
    return Scaffold(
        appBar: AppBar(
          actionsIconTheme: IconThemeData(color: Colors.black),
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
                    isListView = false;
                  } else if (choice == 'listView') {
                    isListView = true;
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
                    fillColor: Color.fromARGB(255, 243, 238, 238),
                    prefixIcon:
                        Lottie.asset("assets/images/search.json", height: 60),
                    hintText: 'Search Files',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 192, 187, 187),
                        fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
            Divider(color: const Color.fromARGB(255, 0, 0, 0), thickness: 1),
            Expanded(
              child: (isListView ? buildListView() : buildGridView()),
            )
          ],
        ));
  }

//-------------------------------------------listview-------------------------------------------
  Widget buildListView() {
    return ValueListenableBuilder<List<FileModel>>(
      valueListenable: FileNotifier,
      builder: (context, files, child) {
        files = sorting_Searching(files);

        return ListView.builder(
          itemCount: files.length,
          itemBuilder: (context, index) {
            final file = files[index];
            return Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Card(
                  elevation: 3,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(208, 255, 147, 7),
                      ),
                      height: 60,
                      child: ListTile(
                          onTap: () {
                            openFile(file);
                          },
                          title: Text(
                            file.fileName,
                            style: TextStyle(color: Colors.black),
                          ),
                          leading: Icon(
                            Icons.file_copy,
                            color: Colors.black,
                          ),
                          trailing: popupmenu(file))),
                ));
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
        files = sorting_Searching(files);

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: files.length,
          itemBuilder: (context, index) {
            final file = files[index];
            return GestureDetector(
              onTap: () {
                openFile(file);
              },
              child: Card(
                color: Color.fromARGB(208, 255, 147, 7),
                elevation: 7.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.file_copy_rounded,
                          size: 30.0,
                        ),
                        SizedBox(height: 6),
                        Text(
                          file.fileName,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13.0),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: popupmenu(file),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  //---------------------------sorting and searching------------------------------

  List<FileModel> sorting_Searching(List<FileModel> files) {
    if (isSorted) {
      files.sort((a, b) => b.fileName.compareTo(a.fileName));
    }
    files = files.reversed.toList(); // Reverse the list

    if (searchQuery.isNotEmpty) {
      files = files
          .where((file) =>
              file.fileName.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
    return files;
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

  //--------------------popupmenu-----------------------------

  PopupMenuButton<String> popupmenu(FileModel file) {
    return PopupMenuButton<String>(
      onSelected: (choice) {
        if (choice == "rename") {
          renameFile(file);
        } else if (choice == "delete") {
          _deleteDialog(file);
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'rename',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Rename'),
                Icon(
                  Icons.drive_file_rename_outline_rounded,
                  color: Colors.blue,
                )
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'delete',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Delete"),
                Icon(
                  Icons.delete,
                  color: Colors.red,
                )
              ],
            ),
          ),
        ];
      },
    );
  }

  //---------------------------delete method--------------------------
  Future<void> _deleteDialog(FileModel file) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete ${file.fileName}?',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteFile(file);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
