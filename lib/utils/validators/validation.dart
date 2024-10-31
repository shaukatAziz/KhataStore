
class FormValidators{
  static String? validateEmail(String? value){
    if(value==null|| value.isEmpty){
      return "Email is required";
    }

    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }



  static String? validatePassword(String? value){
    if(value==null || value.isEmpty){
      return 'password is required';
    }
    if(value.length<6){
      return 'password length must be greater then 6';
    }
    return null;
  }
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    String pattern = r'^[0-9]{10}$';  // Example for a 10-digit number
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? validateAmount(String? value){
      if(value==null || value.isEmpty){
        return 'amount is required';
      }
      return null;
  }

}

