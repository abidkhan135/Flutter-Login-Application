import 'package:flutter/material.dart';
import 'package:code_test/viewmodel/loanform_viewmodel.dart';

class LoanForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(),
    );
  }
}

class BodyWidget extends StatefulWidget {
  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  var _isLoading = false;
  final _lastnameFocusNode = FocusNode();
  final _eamilFocusNode = FocusNode();
  final _loanFocusNode = FocusNode();

  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _loanController = TextEditingController();

  final loanViewModel = LoanViewModel();

  @override
  void initState() {
    super.initState();

    _firstnameController.addListener(() {
      loanViewModel.firstnameSink.add(_firstnameController.text);
    });
    _lastnameController.addListener(() {
      loanViewModel.lastnameSink.add(_lastnameController.text);
    });

    _emailController.addListener(() {
      loanViewModel.emailSink.add(_emailController.text);
    });

    _loanController.addListener(() {
      loanViewModel.loanSink.add(_loanController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _loanController.dispose();
    _lastnameFocusNode.dispose();
    _eamilFocusNode.dispose();
    _loanFocusNode.dispose();
    loanViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.symmetric(horizontal: 40,vertical: 30),
      child: Center(
        child: ListView(
          children: <Widget>[
            StreamBuilder<String>(
                stream: loanViewModel.firstnameStream,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _firstnameController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person_outline),
                        hintText: 'first name',
                        labelText: 'First name',
                        errorText: snapshot.data),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_lastnameFocusNode);
                    },
                  );
                }),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<String>(
                stream: loanViewModel.lastnameStream,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _lastnameController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person_outline),
                        hintText: 'last name',
                        labelText: 'Last name',
                        errorText: snapshot.data),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_eamilFocusNode);
                    },
                    focusNode: _lastnameFocusNode,
                  );
                }),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<String>(
                stream: loanViewModel.emailStream,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'abcs@gmail.com',
                        labelText: 'Email@',
                        errorText: snapshot.data),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_loanFocusNode);
                    },
                    focusNode: _eamilFocusNode,
                  );
                }),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<String>(
                stream: loanViewModel.loanStream,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _loanController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        icon: Icon(Icons.attach_money),
                        labelText: 'Loan Amount',
                        errorText: snapshot.data),
                    textInputAction: TextInputAction.done,
                    focusNode: _loanFocusNode,
                  );
                }),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 80,
              height: 50,
              child: StreamBuilder<bool>(
                  stream: loanViewModel.btnStream,
                  builder: (context, snapshot) {
                    return _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : RaisedButton(
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: snapshot.data == true
                                ? () {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    loanViewModel.submitApplication().then((_) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Success!'),
                                            content: const Text(
                                                'This application is added to system.'),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }).catchError((onError) {
                                      var exceptionType =
                                          onError.toString().split(':');
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      return showDialog<Null>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(exceptionType[0]),
                                          content: Text(exceptionType[1]),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                                  }
                                : null,
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
