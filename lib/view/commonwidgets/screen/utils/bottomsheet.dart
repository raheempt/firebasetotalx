// import 'package:firebasetotalx/utils/validators.dart';
// import 'package:firebasetotalx/view/commonwidgets/customtextfiled.dart';
// import 'package:flutter/material.dart';


// void showCustomBottomSheet(BuildContext context) {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController userageController = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   showModalBottomSheet(
//     isScrollControlled: true,
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
//     ),
//     builder: (BuildContext context) {
//       final Size size = MediaQuery.of(context).size;
//       // final pickImageProvider = Provider.of<PickImageProvider>(context);
//       // final homeScreenProvider = Provider.of<HomeScreenProvider>(context);

//       return SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: Container(
//             padding: const EdgeInsets.all(16.0),
//             height: size.height * .6,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
//             ),
//             child: Form(
//               key: formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Container(
//                       height: 5,
//                       width: 50,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'Add new user',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Stack(
//                         children: [
//                           // CircleAvatar(
//                           //   radius: 50,
//                           //   backgroundImage: pickImageProvider.image != null
//                           //       ? FileImage(File(pickImageProvider.image!.path)) as ImageProvider
//                           //       : const AssetImage(AppImages.profileImg),
//                           // ),
//                           // Positioned(
//                           //   bottom: 0,
//                           //   left: size.width * .06,
//                           //   child: IconButton(
//                           //     onPressed: () async {
//                           //       await pickImageProvider.pickImage();
//                           //     },
//                           //     icon: const Icon(
//                           //       Icons.camera_alt_outlined,
//                           //       color: Colors.white,
//                           //       size: 30,
//                           //     ),
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: size.height * .05),
//                   CustomTextField(
//                     validator: (value) =>
//                         ValidatorFunctions.nameValidation(value),
//                     inputType: TextInputType.text,
//                     hintText: 'User name',
//                     textEditingController: usernameController,
//                   ),
//                   SizedBox(
//                     height: size.height * .01,
//                   ),
//                   CustomTextField(
//                     validator: (value) =>
//                         ValidatorFunctions.ageValidation(value),
//                     inputType: TextInputType.number,
//                     hintText: 'Age',
//                     textEditingController: userageController,
//                   ),
//                   SizedBox(height: size.height * .02),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text('Cancel'),
//                       ),
//                       SizedBox(
//                         width: size.width * .05,
//                       ),
//                       ElevatedButton(
//                         onPressed: () async {
//                           if (formKey.currentState!.validate()) {
//                             developer.log('Submitting user with image');
//                             // await pickImageProvider.uploadImage(pickImageProvider.image);
//                             // final imageUrl = pickImageProvider.imageUrl;
//                             if (imageUrl != null) {
//                               final newUser = UserModel(
//                                 username: usernameController.text.trim(),
//                                 age: int.parse(userageController.text.trim()),
//                                 imageUrl: imageUrl,
//                               );
//                               await homeScreenProvider.addNewUser(newUser);                
//                             }
//                           } 
//                         },
//                         child: const Text('Save'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
import 'dart:developer' as developer;
import 'package:firebasetotalx/model/usermodel.dart';
import 'package:firebasetotalx/providers/homescreenprovider.dart';
import 'package:firebasetotalx/utils/validators.dart';
import 'package:firebasetotalx/view/commonwidgets/customtextfiled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showCustomBottomSheet(BuildContext context) {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController userageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (BuildContext context) {
      final Size size = MediaQuery.of(context).size;
      final homeScreenProvider =
          Provider.of<HomeScreenProvider>(context, listen: false);

      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: size.height * 0.55,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Add new user',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),

                  /// 🔹 Username field
                  CustomTextField(
                    validator: (value) =>
                        ValidatorFunctions.nameValidation(value),
                    inputType: TextInputType.text,
                    hintText: 'User name',
                    textEditingController: usernameController,
                  ),
                  SizedBox(height: size.height * 0.015),

                  /// 🔹 Age field
                  CustomTextField(
                    validator: (value) =>
                        ValidatorFunctions.ageValidation(value),
                    inputType: TextInputType.number,
                    hintText: 'Age',
                    textEditingController: userageController,
                  ),
                  SizedBox(height: size.height * 0.03),

                  /// 🔹 Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      SizedBox(width: size.width * 0.05),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            developer.log('Adding new user...');
                            final newUser = UserModel(
                              username: usernameController.text.trim(),
                              age: userageController.text.trim(), uid: ''
                            );

                            await homeScreenProvider.addNewUser(newUser);

                            // Close bottom sheet
                            Navigator.pop(context);

                            // Refresh the list after adding
                            await homeScreenProvider.getAllUsers();
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
