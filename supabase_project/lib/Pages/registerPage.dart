import 'package:flutter/material.dart';
import 'package:supabase_project/Authentication/authService.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //get auth services
  final authService = Authservice();
  //text controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  //sign up button pressed
  void signUp() async {
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    //check if passwords are matched
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Passwords don't match")));
      return;
    }

    //attempt Sign Up
    try {
      await authService.signUpWithEmailPassword(email, password);
      //pop the register page
      Navigator.pop(context);
    }

    //catch any error
    catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error : $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
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
            height: 10,
          ),
          //Confirm password
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
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(
                      hintText: "confirm password", border: InputBorder.none),
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
                signUp();
              },
              child: const Text("Sign Up")),
        ]),
      ),
    );
  }
}
