import 'dart:async';
import 'package:code_test/helper/Validation.dart';
import 'package:code_test/models/application.dart';
import 'package:rxdart/rxdart.dart';
import 'package:code_test/api/api.dart';

class LoanViewModel {
  final _firstnameSubject = BehaviorSubject<String>();
  final _lastnameSubject = BehaviorSubject<String>();
  final _emailSubject = BehaviorSubject<String>();
  final _loanSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();
  var api = MockAPI();

  var firstnameValidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (firstname, sink) {
    sink.add(Validation.validateFname(firstname));
  });
  var lastnameValidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (lastname, sink) {
    sink.add(Validation.validateLname(lastname));
  });
  var emailValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    sink.add(Validation.valideEmail(email));
  });
  var loanValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (loan, sink) {
    sink.add(Validation.validateLoan(loan));
  });

  Stream<String> get firstnameStream =>
      _firstnameSubject.stream.transform(firstnameValidation);

  Sink<String> get firstnameSink => _firstnameSubject.sink;

  Stream<String> get lastnameStream =>
      _lastnameSubject.stream.transform(lastnameValidation);

  Sink<String> get lastnameSink => _lastnameSubject.sink;

  Stream<String> get emailStream =>
      _emailSubject.stream.transform(emailValidation);

  Sink<String> get emailSink => _emailSubject.sink;

  Stream<String> get loanStream =>
      _loanSubject.stream.transform(loanValidation);

  Sink<String> get loanSink => _loanSubject.sink;

  Stream<bool> get btnStream => _btnSubject.stream;

  Sink<bool> get btnSink => _btnSubject.sink;

  LoanViewModel() {
    Rx.combineLatest4(
        _firstnameSubject, _lastnameSubject, _emailSubject, _loanSubject,
        (firstname, lastname, email, loan) {
      return (Validation.validateFname(firstname) == null &&
          Validation.validateLname(lastname) == null &&
          Validation.valideEmail(email) == null &&
          Validation.validateLoan(loan) == null);
    }).listen((enable) {
      btnSink.add(enable);
    });
  }

  Future<void> submitApplication() async {
    var loan = double.parse(_loanSubject.value);

    var a1 = _application(
        firstName: _firstnameSubject.value,
        lastName: _lastnameSubject.value,
        email: _emailSubject.value,
        loan: loan);
    try {
      await api.submitApplication(a1);
    } catch (onError) {
      throw onError;
    }
  }

  Application _application(
      {String firstName, String lastName, String email, double loan}) {
    return Application(
        firstName: _firstnameSubject.value,
        lastName: _lastnameSubject.value,
        email: _emailSubject.value,
        loanAmount: loan);
  }

  Future<List<Application>> getApplication() {
    return api.getApplications().catchError((onError) {
      throw onError;
    });
  }

  dispose() {
    _firstnameSubject.close();
    _lastnameSubject.close();
    _emailSubject.close();
    _loanSubject.close();
    _btnSubject.close();
  }
}
