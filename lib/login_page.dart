import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled6/comment.dart';
import 'package:untitled6/home_class.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up and save user data to Firestore
  Future<void> _signup() async {
    try {
      // Create a new user with email and password
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Check if user is successfully created
      if (userCredential.user != null) {
        // Save user data to Firestore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
        });

        // Navigate to the next page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeClass()),
        );
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CommentScreen()),
        );
      }
    } catch (e) {
      print("Error: $e");
      // Handle error (you can display a dialog or snackbar here)
    }
  }

  // Login navigation function
  void _goToLoginPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          HomeClass()), // Replace LoginPage with the actual login page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF7d786b),
        title: Text(
          'Comments',
          style: TextStyle(
            color: Colors.blueAccent,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 55,),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      filled: true, // Enables background color
                      fillColor: Colors.blue.shade100,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                    ),
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Enter Name'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true, // Enables background color
                    fillColor: Colors.blue.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(
                        color: Colors.blue, // Set the border color to blue
                      ),
                    ),
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Enter Email',
                  ),
                ),

                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      filled: true, // Enables background color
                      fillColor: Colors.blue.shade100,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24)
                    ),
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Enter Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 200),
                ElevatedButton(
                  onPressed: () {
                    Get.to(CommentScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18), // Increase the button size
                    textStyle: const TextStyle(fontSize: 18), // Text size
                  ),
                  child: const Text('Sign Up',style: TextStyle(fontWeight:FontWeight.bold),),
                ),


                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: _goToLoginPage,
                      child: const Text('Login',style: TextStyle(color: Colors.blue,fontSize: 20),),
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