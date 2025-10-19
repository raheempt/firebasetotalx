
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:firebasetotalx/services/firebaseservices.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Register Firebase core services
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);

  // Register FirebaseService with dependencies
  sl.registerLazySingleton(() => FirebaseService(
        auth: sl<FirebaseAuth>(),
        firestore: sl<FirebaseFirestore>(),
        storage: sl<FirebaseStorage>(),
      ));
}
