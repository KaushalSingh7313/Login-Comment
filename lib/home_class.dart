import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled6/comment.dart';
import 'package:untitled6/login_page.dart';

class HomeClass extends StatefulWidget {
  const HomeClass({Key? key}) : super(key: key);

  @override
  State<HomeClass> createState() => _LoginPageState();
}

class _LoginPageState extends State<HomeClass> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login function
  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Check if login was successful
      if (userCredential.user != null) {
        // Navigate to the next screen or homepage on successful login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  SignupPage()),
        );
      }
    } catch (e) {
      print("Login Error: $e");
      // Show error message or alert
    }
  }

  // Signup navigation function
  void _goToCommetScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CommentScreen()),

    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          title:  Text(
            'Comments',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          )

      ),
      body: Container(
        color: const Color(0xFF7d786b),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 55,),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true, // Enables background color
                    fillColor: Colors.blue.shade100,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24)
                    ),
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Enter email',),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      filled: true, // Enables background color
                      fillColor: Colors.blue.shade100,
                    border: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(24)
                    ),
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Enter Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 245),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue, // Text color
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15), // Increase the button size
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: const Text('Login'),
                ),
          
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("New here?"),
                    TextButton(
                      onPressed:(){Get.to(SignupPage());},
                      child: const Text('Sign Up',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 16),),
                    ),
          
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
