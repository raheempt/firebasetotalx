
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetotalx/idcontainer.dart' as di;
import 'package:firebasetotalx/providers/authprovider.dart';
import 'package:firebasetotalx/providers/homescreenprovider.dart';
import 'package:firebasetotalx/providers/singoutprovider.dart';
import 'package:firebasetotalx/view/commonwidgets/screen/authentication/phonenumberscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart'; // Generated automatically by FlutterFire CLI

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize your DI container here if needed
  await di.initDependencies(); // make sure this function exists in idcontainer.dart

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
          create: (_) => HomeScreenProvider(),),
            ChangeNotifierProvider(create: (_)=>SignOutProvider()),
            

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const PhoneNumberScreen(),
      ),
    );
  }
}
