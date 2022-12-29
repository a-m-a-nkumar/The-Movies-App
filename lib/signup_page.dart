import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_app/home_page.dart';
import 'package:movies_app/model/user_model.dart';

class signup_page extends StatefulWidget {
  const signup_page({Key? key}) : super(key: key);

  @override
  State<signup_page> createState() => _signup_pageState();
}

class _signup_pageState extends State<signup_page> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  final TextEditingController emailcontroller= TextEditingController();
  final TextEditingController passwordcontroller=TextEditingController();
  final TextEditingController firstnamecontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          backgroundColor: Colors.black,
        ),
        body:Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,0,8,8),
                    child: Container(

                        child: SizedBox(
                          height: 280,
                          child: Image.asset(
                            'assets/download (2).png',
                            color: Colors.white,
                            fit: BoxFit.contain,
                          ),
                        )
                    ),
                  ),
                  Form(
                      key: formkey,
                      child:Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,235,10),
                            child: Text('First Name :'),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,0,20,10),
                            child: TextFormField(
                              controller: firstnamecontroller,
                              enableSuggestions: false,
                              validator: (value) {
                                RegExp regex = new RegExp(r'^.{3,}$');
                                if (value!.isEmpty) {
                                  return ("First Name cannot be Empty");
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("Enter Valid name(Min. 3 Character)");
                                }
                                return null;
                              },
                              onSaved: (value) {
                                firstnamecontroller.text = value!;
                              },
                              autocorrect: false,
                              textInputAction: TextInputAction.next,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                  prefixIcon: Icon(Icons.email,color: Colors.black,),
                                  labelText: 'Enter Your First Name',
                                  floatingLabelBehavior:FloatingLabelBehavior.never,
                                  filled: true,
                                  fillColor:Colors.white70,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                  )


                              ),
                              keyboardType:TextInputType.name,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,210,10),
                            child: Text('Email Address :'),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,0,20,10),
                            child: TextFormField(
                              controller: emailcontroller,
                              enableSuggestions: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Please Enter Your Email");
                                }
                                // reg expression for email validation
                                if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
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

                                  prefixIcon: Icon(Icons.email,color: Colors.black,),
                                  labelText: 'Enter Your Email',
                                  floatingLabelBehavior:FloatingLabelBehavior.never,
                                  filled: true,
                                  fillColor:Colors.white70,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                  )


                              ),
                              keyboardType:TextInputType.emailAddress,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,230,10),
                            child: Text('Password :'),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,0,20,10),
                            child: TextFormField(
                              controller: passwordcontroller,
                              obscureText: true,
                              validator: (value) {
                                RegExp regex = new RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return ("Password is required for login");
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("Enter Valid Password(Min. 6 Character)");
                                }
                              },
                              onSaved: (value) {
                                passwordcontroller.text = value!;
                              },
                              textInputAction: TextInputAction.done,
                              enableSuggestions: false,
                              autocorrect: false,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                  prefixIcon: Icon(Icons.lock,color: Colors.black,),
                                  labelText: 'Enter Your Password',
                                  floatingLabelBehavior:FloatingLabelBehavior.never,
                                  filled: true,
                                  fillColor:Colors.white70,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                  )


                              ),
                              keyboardType:TextInputType.visiblePassword,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,30,20,5),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                              child: ElevatedButton(

                                child: Text('Sign Up'),
                                onPressed: (){
                                  signUp(emailcontroller.text, passwordcontroller.text);
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                                      if(states.contains(MaterialState.pressed)){
                                        return Colors.black26;
                                      }
                                      return Colors.grey;
                                    }),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                                    )

                                ),
                              ),
                            ),
                          ),
                        ],
                      ) )
                ],
              ),
            ),
          ),
        )
    );
  }

  void signUp(String email, String password) async {
    if (formkey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    user_model userModel = user_model();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstname = firstnamecontroller.text;


    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => home_page()),
            (route) => false);
  }

}
