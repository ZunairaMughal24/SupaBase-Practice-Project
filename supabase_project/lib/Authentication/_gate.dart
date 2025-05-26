/* this will continue will listen to auth state changes
----------------------------------------------------------------------

 unauthenticated -> Login page
 authenticated -> profile page
 */
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_project/Pages/AuthPages/loginPage.dart';
import 'package:supabase_project/Pages/AuthPages/profilePage.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        //listen to auth state changes
        stream: Supabase.instance.client.auth.onAuthStateChange,

        // build the appropriate page based on auth state
        builder: (context, snapshot) {
          // if loading.....
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          // check if there is a valid session currently
          final session = snapshot.hasData ? snapshot.data!.session : null;
          if (session != null) {
            return const ProfilePage();
          } else {
            return const LoginPage();
          }
        });
  }
}
