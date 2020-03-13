class Validation{

  static String validateFname(String fname){
    if (fname.length==0 ){
      return "Enter first name";
    }
    else if(fname.length>50){
      return "length must be less than 50 characters";
    }
    else return null;
  }

  static String validateLname(String lname){
    if (lname.length==0 ){
      return "Enter last name";
    }
    else if(lname.length>50){
      return "length must be less than 50 characters";
    }
    else return null;
  }

  static String validateLoan(String loan){
    int result =0;
       result = int.parse(loan);
       if (result > 10000 && result < 500000){
         return null;
    } else return "Invalid Amount";
  }
  static String valideEmail(String email){

    if(email==null){
      return "Email Invalid";
    }

    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if (!emailValid){
      return "Email Invalid";
    }
    return null;

  }
}