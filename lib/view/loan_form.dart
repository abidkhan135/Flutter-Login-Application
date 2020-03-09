import 'package:flutter/material.dart';
import 'package:code_test/viewmodel/loanform_viewmodel.dart';

class LoanForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  BodyWidget(),
    );
  }
}
class BodyWidget extends StatefulWidget {
  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {

  final firstnameController= TextEditingController();
  final lastnameController= TextEditingController();
  final emailController= TextEditingController();
  final passController= TextEditingController();

  final loginViewModel= LoginViewModel();

  @override
  void initState() {
    super.initState();

    firstnameController.addListener(() {
      loginViewModel.firstnameSink.add(firstnameController.text);
    });
    lastnameController.addListener(() {
      loginViewModel.lastnameSink.add(lastnameController.text);
    });

    emailController.addListener(() {
      loginViewModel.emailSink.add(emailController.text);
    });

    passController.addListener(() {
      loginViewModel.passSink.add(passController.text);
    });


  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loginViewModel.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40,right: 40),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            StreamBuilder<String>(
                stream: loginViewModel.firstnameStream,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: firstnameController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'firstname',
                        labelText: 'First name',
                        errorText: snapshot.data
                    ),
                  );
                }
            ),
            SizedBox(height: 20,),
            StreamBuilder<String>(
                stream: loginViewModel.lastnameStream,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: lastnameController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'last',
                        labelText: 'Last name',
                        errorText: snapshot.data
                    ),
                  );
                }
            ),
            SizedBox(height: 20,),
            StreamBuilder<String>(
                stream: loginViewModel.emailStream,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'abcs@gmail.com',
                        labelText: 'Email@',
                        errorText: snapshot.data
                    ),
                  );
                }
            ),
            SizedBox(height: 20,),
            StreamBuilder<String>(
                stream: loginViewModel.passStream,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: passController,
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: 'Password*',
                        errorText: snapshot.data
                    ),
                  );
                }
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: 200,
              height: 45,
              child: StreamBuilder<bool>(
                  stream: loginViewModel.btnStream,
                  builder: (context, snapshot) {
                    return RaisedButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      onPressed: snapshot.data==true ? (){
                        //call login APi
                        print("Button is pressed");
                      }:null ,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    );
                  }
              ),
            )
          ],
        ),
    );
  }
}

 