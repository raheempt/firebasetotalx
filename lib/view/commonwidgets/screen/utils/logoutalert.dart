// import 'package:firebasetotalx/providers/singoutprovider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// void showLogoutConfirmationDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Confirm Logout'),
//         content: Text('Are you sure you want to log out?'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); 
//             },
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//             Provider.of<SignOutProvider>(context,listen: false).signOutUser();
//             },
//             child: Text('Logout'),
//           ),
//         ],
//       );
//     },
//   );
// }
// lib/view/commonwidgets/screen/uiutilities/logoutalert.dart
import 'package:firebasetotalx/providers/singoutprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to log out?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
            Provider.of<SignOutProvider>(context, listen: false).signOut();
          },
          child: const Text('Logout'),
        ),
      ],
    ),
  );
}
