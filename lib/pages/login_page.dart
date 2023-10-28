import 'package:flutter/material.dart';
import 'package:namer_app_web/Components/my_Textfield.dart';
import 'package:namer_app_web/components/my_button.dart';
import 'package:namer_app_web/components/square_tile.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method

  void signUserIn() {}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //logo
            Icon(
              Icons.lock,
              size: 80,
            ),

            SizedBox(height: 30),

            //welcome back
            Text(
              'Welcome back, you\'ve been missed',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),

            SizedBox(height: 30),

            //username textfield

            MyTextField(
              controller: usernameController,
              hintText: 'Username',
              obscureText: false,
            ),

            //password textfield

            SizedBox(height: 20),

            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),

            SizedBox(height: 10),

            //forgot password?

            Text(
              'Forgot password?',
              style: TextStyle(color: Colors.grey[500]),
            ),

            SizedBox(height: 20),

            //Sign in button

            MyButton(
              onTap: signUserIn,
            ),

            SizedBox(height: 20),

            //Or continue with

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Or continue with",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                    ),
                  )
                ],
              ),
            ),
            //google sign in button

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SquareTile(imagePath: 'lib/images/google.png')],
            ),

            SizedBox(height: 20),

            //not a member? register now

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 4),
                Text(
                  'Register now',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
