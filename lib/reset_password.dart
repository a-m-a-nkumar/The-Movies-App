import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_app/home_page.dart';
import 'package:movies_app/model/user_model.dart';

class resetpassword_page extends StatefulWidget {
  const resetpassword_page({Key? key}) : super(key: key);

  @override
  State<resetpassword_page> createState() => _resetpassword_pageState();
}

class _resetpassword_pageState extends State<resetpassword_page> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  final TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reset Password', style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.black,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Container(

                        child: SizedBox(
                          height: 280,
                          child: Image.asset(
                            'assets/synchronize.png',
                            color: Colors.white,
                            fit: BoxFit.contain,
                          ),
                        )
                    ),
                  ),
                  Form(
                      key: formkey,
                      child: Column(
                        children: [


                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 210, 10),
                            child: Text('Email Address :'),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: TextFormField(
                              controller: emailcontroller,
                              enableSuggestions: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Please Enter Your Email");
                                }
                                // reg expression for email validation
                                if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return ("Please Enter a valid email");
                                }
                                return null;
                              },
                              onSaved: (value) {
                                emailcontroller.text = value!;
                              },
                              textInputAction: TextInputAction.next,
                              autocorrect: true,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                  prefixIcon: Icon(
                                    Icons.email, color: Colors.black,),
                                  labelText: 'Enter Your Email',
                                  floatingLabelBehavior: FloatingLabelBehavior
                                      .never,
                                  filled: true,
                                  fillColor: Colors.white70,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          width: 0, style: BorderStyle.none)
                                  )


                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: ElevatedButton(

                                child: Text('Reset Password'),
                                onPressed: () {
                                  FirebaseAuth.instance.sendPasswordResetEmail(
                                      email: emailcontroller.text).then((
                                      value) => Navigator.of(context).pop());
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith((states) {
                                      if (states.contains(
                                          MaterialState.pressed)) {
                                        return Colors.black26;
                                      }
                                      return Colors.grey;
                                    }),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20))
                                    )

                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        )
    );
  }
}

