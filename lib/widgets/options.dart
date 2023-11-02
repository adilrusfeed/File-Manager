// import 'package:flutter/material.dart';

// void showOptions(BuildContext context) {
//   final RenderBox overlay =
//       Overlay.of(context).context.findRenderObject() as RenderBox;
//   showMenu(
//     context: context,
//     position: RelativeRect.fromRect(
//       Rect.fromPoints(Offset(0, 0),
//           overlay.localToGlobal(overlay.size.bottomRight(Offset(0, 0)))),
//       Offset.zero & overlay.size,
//     ),
//     items: <PopupMenuEntry>[
//       PopupMenuItem(
//         value: 'edit',
//         child: Text('Edit'),
//       ),
//       PopupMenuItem(
//         value: 'delete',
//         child: Text('Delete'),
//       ),
//     ],
//   ).then((value) {
//     if (value == 'edit') {
//       // Handle the edit action
//     } else if (value == 'delete') {
//       // Handle the delete action
//     }
//   });
// }

import 'package:flutter/material.dart';

class menu extends StatelessWidget {
  const menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          color: Colors.grey,
        ),
        Container(
          height: 50,
          color: Colors.grey,
        ),
        Container(
          height: 50,
          color: Colors.grey,
        )
      ],
    );
  }
}
