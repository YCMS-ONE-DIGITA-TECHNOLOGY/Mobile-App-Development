class AppValidators {
  // Amount Validation
  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) return 'Please enter an amount';
    
    final n = num.tryParse(value.replaceAll(RegExp(r'[^0-9.]'), ''));
    if (n == null) return 'Invalid number format';
    if (n <= 0) return 'Amount must be greater than zero';
    
    return null;
  }

  // Email Validation (For Auth Screen)
  static String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || value.isEmpty) return 'Email is required';
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email address';
    return null;
  }
}