class Validation{

  static String validateFname(String fname){
    if (fname.length==0){
      print("inside null");
      return "Enter first name";
    }

    print("inside first name"+fname);
    return null;
  }

  static String validateLname(String lname){
    if (lname==null){
      return "Enter last name";
    }
    if (lname.length>50){
      return "Must be less than 50 character";
    }
    return null;
  }

  static String validatePass(String pass){
    if (pass==null){
      return "Password Invalid";
    }
    if (pass.length<6){
      return "Pass required 6 character";
    }
    return null;
  }
  static String valideEmail(String email){

    if(email==null){
      return "Email Invalid";
    }
    //var isvalid= RegExp("[a-zA-Z0-9.] +@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    var isvalid=true;
    if (!isvalid){
      return "Email Invalid";
    }
    return null;

  }
}