import 'package:final_project/Components/CategoriesList.dart';
import 'package:final_project/Models/MenuDetailsParam.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> getUserCred() async {
    Map<String, String> allValues = await secureStorage.readAll();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      getUserCred();
    }
    return Scaffold(
      appBar: AppBar(title: Text('Home'), actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
            icon: Icon(Icons.copyright_rounded))
      ]),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Tired of cooking same thing ?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ))
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, '/menuDetails', arguments: MenuDetailsParam(randomize: true));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Try Random Recipe',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Browse by Categories",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ))
              ],
            ),
            Expanded(
              // mainAxisAlignment: MainAxisAlignment.start,
              child: Categories_List(),
            ),
          ],
        ),
      ),
    );
  }
}
