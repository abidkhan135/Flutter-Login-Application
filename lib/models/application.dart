 import 'package:meta/meta.dart';

///
/// Application model.
/// The domain representation of the application.
///
class Application {
  final String firstName;
  final String lastName;
  final String email;
  final double loanAmount;

  Application({@required this.firstName, @required this.lastName, @required this.email, @required this.loanAmount})
      : assert(firstName != null || firstName.isEmpty),
        assert(lastName != null || lastName.isEmpty),
        assert(email != null || email.isEmpty),
        assert(loanAmount != null);

  @override
  String toString() => 'Application{firstName: $firstName, lastName: $lastName, email: $email, loanAmount: $loanAmount}';
}
