bool isEmailValid(String email) {
  // Regular expression for a valid email address
  final emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    caseSensitive: false,
  );
  
  return emailRegex.hasMatch(email);
}