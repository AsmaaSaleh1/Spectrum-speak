// Email validation function
bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return email.isNotEmpty && emailRegex.hasMatch(email);
}
// Phone validation function
bool isValidPhoneNumber(String phoneNumber) {
  return int.tryParse(phoneNumber) != null;
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
  //TODO: check if the date is not come yet
  return dateRegExp.hasMatch(input);
}