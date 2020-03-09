import 'dart:math';

import 'package:code_test/models/application.dart';
import 'package:meta/meta.dart';

/// Exception thrown when a timeout towards the api has happened.
/// We should probably retry to send the request.
class ApiTimeoutException implements Exception {
  final String message;

  ApiTimeoutException([this.message]);

  @override
  String toString() => (this.message != null ? "ApiTimeoutException: $message" : "ApiTimeoutException");
}

/// Exception thrown when the api is unable to handle the request and an Internal error has occurred.
/// Something has broken in the api and we should inform the user and not resend the request.
class ApiInternalServerException implements Exception {
  final String message;

  ApiInternalServerException([this.message]);

  @override
  String toString() => (this.message != null ? "ApiInternalServerException: $message" : "ApiInternalServerException");
}

///
/// Interface for the API.
///
abstract class API {
  ///
  /// Submits a [application] to the api.
  ///
  Future<Application> submitApplication(Application application);

  ///
  /// Retrieves all previously submitted [Application].
  ///
  Future<List<Application>> getApplications();
}

///
/// [API] implementation with mocked data
///
class MockAPI extends API {
  // List containing mocked applications.
  final List<Application> _applications = [
    Application(firstName: "Kjell Börje", lastName: "Zerykier", email: "kjell@example.com", loanAmount: 50000),
    Application(firstName: "Thomas", lastName: "Danielsson", email: "thomas@example.com", loanAmount: 100000),
    Application(firstName: "Axel", lastName: "Morell", email: "axel@example.com", loanAmount: 150000),
    Application(firstName: "Louise", lastName: "Perttuula", email: "louise@example.com", loanAmount: 123456),
    Application(firstName: "Åsa", lastName: "Wifler", email: "asa@example.com", loanAmount: 250000),
    Application(firstName: "Ingvar", lastName: "Ehn", email: "ingvar@example.com", loanAmount: 300000),
    Application(firstName: "Bernt", lastName: "Persson", email: "bernt@example.com", loanAmount: 450000),
    Application(firstName: "Ingrid", lastName: "Margareta", email: "ingrid@example.com", loanAmount: 500000),
  ];
  final int _errorChance;
  final int _maxDelayInSeconds;

  MockAPI()
      : // There is a 1 in 5 chance of throwing an exception
        this._errorChance = 5,
        this._maxDelayInSeconds = 10;

  @visibleForTesting
  MockAPI.test({int errorChance, delay})
      : this._errorChance = errorChance,
        this._maxDelayInSeconds = delay;

  @override
  Future<Application> submitApplication(Application application) async {
    // Check if argument [application] is null
    ArgumentError.checkNotNull(application, 'application');

    // Add a faked delay to simulate a real http request.
    if (_maxDelayInSeconds != null) {
      await Future.delayed(Duration(seconds: Random().nextInt(_maxDelayInSeconds)));
    }

    // Check if we should simulate an error.
    if (_errorChance != null && (_errorChance == 1 || Random().nextInt(_errorChance) == 0)) {
      throw Random().nextBool()
          ? ApiTimeoutException('A timeout occurred during while submitting the application')
          : ApiInternalServerException('A fatal error occurred while submitting the application');
    }

    // Add application to list of applications.
    _applications.add(application);

    // Return with the application.
    return application;
  }

  @override
  Future<List<Application>> getApplications() async {
    // Add a faked delay to simulate a real http request.
    if (_maxDelayInSeconds != null) {
      await Future.delayed(Duration(seconds: Random().nextInt(_maxDelayInSeconds)));
    }

    // Check if we should simulate an error.
    if (_errorChance != null && (_errorChance == 1 || Random().nextInt(_errorChance) == 0)) {
      throw Random().nextBool()
          ? ApiTimeoutException('A timeout occurred during while retrieving the applications')
          : ApiInternalServerException('A fatal error occurred while retrieving the applications');
    }

    // Return applications
    return _applications;
  }
}
