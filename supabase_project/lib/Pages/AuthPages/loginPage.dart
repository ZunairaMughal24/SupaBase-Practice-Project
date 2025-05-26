import 'package:flutter/material.dart';
import 'package:supabase_project/Authentication/authService.dart';
import 'package:supabase_project/Pages/AuthPages/registerPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//get auth services
  final authService = Authservice();
  //text controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //login button pressed
  void logIn() async {
    //prepare data
    final email = emailController.text;
    final password = passwordController.text;
    //attempt login
    try {
      await authService.signInWithEmailPassword(email, password);
    }
    //catch any error
    catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error : $e")));
      }
    }
  }

// build Ui
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 14),
        child: ListView(children: [
          //email
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 231, 231, 231),
              ),
              color: const Color.fromARGB(255, 178, 220, 255),
              borderRadius: BorderRadius.circular(16),
            ),
            height: 45,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    hintText: "email", border: InputBorder.none),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //password
          Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 231, 231, 231),
                ),
                color: const Color.fromARGB(255, 178, 220, 255),
                borderRadius: BorderRadius.circular(16),
              ),
              height: 45,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      hintText: "password", border: InputBorder.none),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          // button to log in
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 4,
              ),
              onPressed: () {
                logIn();
              },
              child: const Text("LogIn")),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child:
                  const Center(child: Text("Don't have an account? Sign Up")))
        ]),
      ),
    );
  }
}
