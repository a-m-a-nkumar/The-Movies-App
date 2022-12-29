import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/home_page.dart';
import 'package:movies_app/reset_password.dart';
import 'package:movies_app/signup_page.dart';

class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final formkey = GlobalKey<FormState>();
  bool ischecked=false;
  final TextEditingController emailcontroller= TextEditingController();
  final TextEditingController passwordcontroller=TextEditingController();

  late Box box1;

  @override
  void initState(){
    super.initState();
    createBox();

  }

  void createBox()async{
    box1=await Hive.openBox('logindata');
    getdata();
  }
  void getdata()async{
    if(box1.get('email')!=null){
      emailcontroller.text=box1.get('email');
    }
    if(box1.get('password')!=null){
      passwordcontroller.text=box1.get('password');
    }
  }
  String? errorMessage;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child:  SingleChildScrollView(
          child: Column(
          children: [
           Padding(
             padding: const EdgeInsets.fromLTRB(8,20,8,8),
             child: Container(

                 child: Image.asset(
                  'assets/780122-200.png',
                   color: Colors.white,
                 )
             ),
           ),
            Form(
                key: formkey,
                child:Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,60,210,10),
                      child: Text('Email Address :'),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,20,10),
                      child: TextFormField(
                        autofocus: false,
                        controller: emailcontroller,
                        enableSuggestions: true,
                        autocorrect: true,
                        validator: (value){
                          if(value!.isEmpty){
                            return ("Please Enter Your Email");
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;

                        },
                        onSaved: (value){
                          emailcontroller.text=value!;
                        },
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,

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
                      padding: const EdgeInsets.fromLTRB(0,10,230,10),
                      child: Text('Password :'),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,20,10),
                      child: TextFormField(
                        controller: passwordcontroller,
                        autofocus: false,
                        textInputAction: TextInputAction.done,
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
                        enableSuggestions: false,
                        onSaved: (value){
                          passwordcontroller.text=value!;
                        },
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
                      padding: const EdgeInsets.fromLTRB(10,0,0,8),
                      child: Row(
                        children: [
                          Checkbox(value: ischecked,
                              onChanged:(value){
                            ischecked = !ischecked;
                            setState(() {

                            });
                              }),
                          Text('Remember Me'),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(110,0,0,0),
                            child: Container(

                              height: 35,
                              alignment: Alignment.bottomRight,
                              child: Flexible(
                                child: TextButton(
                                  child: Text('Forgot Password?',style: TextStyle(color: Colors.white),textAlign: TextAlign.right,),
                                onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>resetpassword_page()));
                                },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,20,5),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                        child: ElevatedButton(

                          child: Text('Login'),
                          onPressed: (){
                            signIn(emailcontroller.text, passwordcontroller.text);
                            login();
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have a account ? "),
                        GestureDetector(
                          child: Text('Sign Up'),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>signup_page()));
                          },
                        )
                      ],
                    )
                  ],
                ) )
          ],
          ),
        ),
      ),
    );
  }
  void login(){
    if(ischecked){
      box1.put('email', emailcontroller.text);
      box1.put('password', passwordcontroller.text);
    }
  }

  void signIn(String email, String password) async {
    if (formkey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
          Fluttertoast.showToast(msg: "Login Successful"),
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => home_page())),
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






}




