import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app_web/Components/my_Textfield.dart';
import 'package:namer_app_web/components/my_button.dart';
import 'package:namer_app_web/components/square_tile.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() async {
    // show a loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign user in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop the circle

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      //USER NOT FOUND
      if (e.code == 'user-not-found') {
        //show error to user
        userNotFoundMessage();
        print('No user found with this email');
      }
      //SOMETHINGS WHONG
      else if (e.code == 'invalid-login-credentials') {
        wrongSomethingMessage();
        print('Check everything again');
      }
      //INVALID EMAIL
      else if (e.code == 'invalid-email') {
        wrongEmailMessage();
        print('You typed email wrong');
      }
      //WRONG PASSWORD
      else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
        print('Password is wrong, buddy');
      }
      //I DUNNO MAN
      else {
        otherErrorMessage();
        print(e.code);
      }
    }
  }

  //USER NOT FOUND message popup
  void userNotFoundMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('User not found'),
        );
      },
    );
  }

  //SOMETHINGS WRONG message popup
  void wrongSomethingMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Check your email and password'),
        );
      },
    );
  }

  //IVALID EMAIL message popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Invalid Email'),
        );
      },
    );
  }

  // WRONG PASSWORD message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect password'),
        );
      },
    );
  }

  //OTHER error message popup
  void otherErrorMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('I dont know man'),
        );
      },
    );
  }

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

            //Email textfield

            MyTextField(
              controller: emailController,
              hintText: 'Email',
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
