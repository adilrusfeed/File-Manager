// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:open_file/open_file.dart';

// class picker extends StatefulWidget {
//   const picker({super.key});

//   @override
//   State<picker> createState() => _pickerState();
// }

// class _pickerState extends State<picker> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Picker Example'),
//           centerTitle: true,
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   pickFiless();
//                 },
//                 child: Text("pick files"),
//               )
//             ],
//           ),
//         ));
//   }

//   void pickFiless() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType. /*custom,allowedExtensions: ['jpg','png']*/ any,
//         allowMultiple: true); //if only certain file
//     if (result == null) return;

//     PlatformFile? file = result!.files.first;
//     viewFile(file);
//   }

//   void viewFile(PlatformFile file) {
//     OpenFile.open(file.path);
//   }
// }
