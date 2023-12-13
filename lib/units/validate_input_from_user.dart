// Email validation function
bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return email.isNotEmpty && emailRegex.hasMatch(email);
}
// Phone validation function
bool isValidPhoneNumber(String phoneNumber) {
  // Adjust the regular expression as needed for your specific requirements
  final RegExp phoneRegex = RegExp(r'^\+?[0-9]+$');
  return phoneRegex.hasMatch(phoneNumber);
}

// Password validation function
bool isPasswordValid(String password) {
  // Password must contain at least one lowercase letter, one uppercase letter,
  // one number, and have a minimum length of 8 characters.
  final passwordRegex =
  RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
  return passwordRegex.hasMatch(password);
}
// decimal(7,2) validation function
bool isDecimal(String input) {
  final RegExp decimalRegExp = RegExp(r'^\d{1,5}(\.\d{1,2})?$');
  return decimalRegExp.hasMatch(input);
}
//Date [yyyy-mm-dd] validation function
bool isDate(String input) {
  final RegExp dateRegExp = RegExp(
      r'^\d{4}-\d{2}-\d{2}$'); // Matches the 'yyyy-mm-dd' format (e.g., '2023-11-29')
  if (!dateRegExp.hasMatch(input)) {
    return false; // Not a valid date format
  }
  DateTime inputDate = DateTime.parse(input);
  DateTime currentDate = DateTime.now();
  return inputDate.isBefore(currentDate); // Return true if the input date is not in the past
}
