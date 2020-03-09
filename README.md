# Fintech code test

This is just a small challenge to see if you're familiar with the flutter framework.
You are free to design the application in anyway you seem fit, also use any [libraries](https://pub.dev/flutter/packages) that you want as long as you'll give an explanation to why you choose them.

# Background
Our dear product owner Oscar Jansson has built a new API that can handle simple loan applications. The API integrate towards different loan providers.
Oscar have no coding experience has therefore created the worst API in history. The API lacks any kind of validation and the server where it is hosted is located in his basement with a very unstable 0,5Mb/s internet connection and is known for timeouts and mysterious crashes.

The API has two functions:
1. Submit a new loan application.
2. Retrieve a list of previously submitted applications.

Oscar has now assigned you to create a hybrid mobile application written in Flutter to integrate with his API.

# Challenge
Your assignment is to create a mobile application in Flutter integrate towards this API.
We've prebuilt a MockAPI that will simulate the integration with the API located at: lib/api/api.dart.
There are no design specifications on how this app should look like, you are free to build it as you seem fit. 
An suggestion would be to use a [BottomNavigationBar](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html) to easily navigate between the two screens.

The requirements are:
1. Screen for new loan application.
	* Application must be validated before submitting, see validations in the Loan application model below.
	* Should show some loading indicator while waiting for success.
	* Handle any errors that could occur during the process. 
1. Screen for viewing previously submitted applications.
	* Display a list of applications
	* Should show some loading indicator while waiting for results.
	* Handle any errors that could occur during the process. 


## Loan application Model

|Field      |Example       			|Validation                   		|
|-----------|-----------------------|-----------------------------------|
|firstName 	|`Thomas`      			|Min: 1 char, Max: 50 chars   		|
|lastName   |`Danielsson`  			|Min: 1 char, Max: 50 chars   		|
|email 		|`thomas@example.com`	|Must be a valid email address. 	|
|loanAmount |`250 000`	 			|Min: 10 000 kr, Max: 500 000 kr	|

## What we will look for

* Clean code
* Maintainable code
* Scalable code
