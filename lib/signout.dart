import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
          backgroundColor: Colors.blueGrey,
          title: Text(
            'Comments',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          )

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.only()),

                    hintText: 'Enter Name'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.only()),
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Enter Email'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.only()),
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Enter Password'),
                obscureText: true,
              ),
              const SizedBox(height: 250),
              ElevatedButton(
                child: Text('Signup'),
                onPressed: () {
                  Get.to(SignupPage());
                },
              ),


              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: _goToLoginPage,
                    child: const Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}