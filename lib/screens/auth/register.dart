import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/config/Palette.dart';
import 'package:job_finder/screens/auth/utils/decoration_functions.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:job_finder/screens/auth/utils/sign_in_up_bar.dart';
import 'package:job_finder/screens/auth/utils/title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatelessWidget {
  const Register({Key key, this.onSignInPressed}) : super(key: key);

  final VoidCallback onSignInPressed;

  @override
  Widget build(BuildContext context) {
    final isSubmitting = context.isSubmitting();
    TextEditingController fullname = TextEditingController();
    final databaseReference =
        FirebaseFirestore.instance.collection("users_data");
    return SignInForm(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: LoginTitle(
                  title: 'Create\nAccount',
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    child: TextFormField(
                        controller: fullname,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                        decoration:
                            registerInputDecoration(hintText: 'Full Name')),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    child: EmailTextFormField(
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                        decoration: registerInputDecoration(hintText: 'Email')),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    child: PasswordTextFormField(
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                      decoration: registerInputDecoration(hintText: 'Password'),
                    ),
                  ),
                  SignUpBar(
                    label: 'Sign up',
                    isLoading: isSubmitting,
                    onPressed: () async {
                      context.registerWithEmailAndPassword();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      createRecord(databaseReference, fullname.text);
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        onSignInPressed?.call();
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Palette.navyBlue,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createRecord(CollectionReference f, String name) async {
    await f.add({'name': name});
  }
}
