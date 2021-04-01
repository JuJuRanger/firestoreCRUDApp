import 'package:firestoreCRUDApp/providers/product_provider.dart';
import 'package:firestoreCRUDApp/screens/product_screen.dart';
import 'package:firestoreCRUDApp/services/firestore_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // ประกาศ widget ให้เรียก https ได้ ให้รองรับการอ่าน
  WidgetsFlutterBinding.ensureInitialized();

  // initial firebase
  await Firebase.initializeApp();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final fireStoreService = FirestoreService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        StreamProvider(create: (context) => fireStoreService.getProducts()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firestore CRUD',
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        home: ProductScreen(),
      ),
    );
  }
}