import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> registerAction() async {
    
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text);
        print(userCredential);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account registered, you can go back now !')));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: Account already exists')));
        print('Account exists');
      }
      else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: Account already exists')));
        print('Account exists');
      }
      else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: Invalid Email')));
        print('Account exists');
      }
      else{
        print(e.code);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.code}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/cooking.png',
                      height: 175,
                      width: 175,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text.rich(
                        TextSpan(
                            text: 'Welcome, New Cook!!\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: "Register Yourself and LET'S COOK !!",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Color(0XFF01579B),
                                ),
                              ),
                            ]),
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0XFF54C5F8),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30,),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0XFF54C5F8)),
                    ),
                    hintText: 'Email',
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0XFF54C5F8)),
                    ),
                    hintText: 'Password',
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () async {
                        await registerAction();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

final countries = ['Monas', 'Roma'];
