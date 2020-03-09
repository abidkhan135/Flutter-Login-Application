
import 'dart:async';
import 'package:code_test/helper/Validation.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel{

  final _firstnameSubject = BehaviorSubject<String>();
  final _lastnameSubject = BehaviorSubject<String>();
  final _emailSubject = BehaviorSubject<String>();
  final _passSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

  var firstnameValidation= StreamTransformer<String,String>.fromHandlers(
      handleData: (firstname,sink){
        sink.add(Validation.validateFname(firstname));
      }
  );

  var lastnameValidation= StreamTransformer<String,String>.fromHandlers(
      handleData: (lastname,sink){
        sink.add(Validation.validateLname(lastname));
      }
  );

  var emailValidation= StreamTransformer<String,String>.fromHandlers(
      handleData: (email,sink){
        sink.add(Validation.valideEmail(email));
      }
  );

  var passValidation= StreamTransformer<String,String>.fromHandlers(
      handleData: (pass,sink){
        sink.add(Validation.validatePass(pass));
      }
  );


  Stream<String> get firstnameStream => _firstnameSubject.stream.transform(firstnameValidation);
  Sink<String> get firstnameSink => _firstnameSubject.sink;

  Stream<String> get lastnameStream => _lastnameSubject.stream.transform(firstnameValidation);
  Sink<String> get lastnameSink => _lastnameSubject.sink;

  Stream<String> get emailStream => _emailSubject.stream.transform(emailValidation);
  Sink<String> get emailSink => _emailSubject.sink;

  Stream<String> get passStream => _passSubject.stream.transform(passValidation);
  Sink<String> get passSink => _passSubject.sink;

  Stream<bool> get btnStream => _btnSubject.stream;
  Sink<bool> get btnSink => _btnSubject.sink;

  LoginViewModel(){
    Rx.combineLatest4(_firstnameSubject,_lastnameSubject,_emailSubject, _passSubject, (firstname,lastname, email ,password){

      return (Validation.validateFname(firstname)==null && Validation.validateLname(lastname)==null && Validation.valideEmail(email)==null  && Validation.validatePass(password)==null);

    }).listen((enable) {
      btnSink.add(enable);
    });


  }

  dispose(){
    _firstnameSubject.close();
    _lastnameSubject.close();
    _emailSubject.close();
    _passSubject.close();
    _btnSubject.close();

  }

}