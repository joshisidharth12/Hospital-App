
String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if(value == ""){
    return 'Email Field is Empty';
  }
  else if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}

String validateName(String value) {
  if(value == ""){
    return 'Name Field is Empty';
  }
  else if (value.length < 3)
    return 'Name must be more than 2 charater';
  else
    return null;
}

String validateAge(String value) {
  if(value == ""){
    return 'Name Field is Empty';
  }
  else if (value.length < 2)
    return 'Name must be more than 2 charater';
  else
    return null;
}

String validatePhone(String value) {
  if(value == ""){
    return 'Password Field is Empty';
  }
  else
    return null;
}

String validatePass(String value) {
  if(value == ""){
    return 'Password Field is Empty';
  }
  else if(value.length < 6)
    return 'Name must be more than 6 charater';
  else
    return null;
}