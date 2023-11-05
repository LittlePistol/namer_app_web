import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app_web/Components/my_Textfield.dart';
import 'package:namer_app_web/components/my_button.dart';
import 'package:namer_app_web/components/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign user UP method
  void signUserUp() async {
    // show a loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try creating the user
    try {
      //check if the password is the same

      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        //show error message
        Navigator.pop(context);
        showErrorMessage('Passwords don\'t match');
      }
      //pop the circle

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(message),
          ),
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
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //logo
              Icon(
                Icons.account_box,
                size: 80,
              ),

              SizedBox(height: 20),

              //Lets create an account
              Text(
                'Lets create an account!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 20),
              //Email textfield

              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              //password textfield

              SizedBox(height: 10),

              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              SizedBox(height: 10),

              //CONFIRM password textfield

              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm password',
                obscureText: true,
              ),

              SizedBox(height: 20),

              //Sign up button

              MyButton(
                onTap: signUserUp,
                text: 'Sign up',
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
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Login now',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20)
            ]),
          ),
        ),
      ),
    );
  }
}
