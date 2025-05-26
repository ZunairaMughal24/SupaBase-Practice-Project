import 'package:flutter/material.dart';
import 'package:supabase_project/Authentication/authService.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authService = Authservice();
  //logOut Button
  void logOut() async {
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Profile page")),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: logOut),
        ],
      ),
    );
  }
}
