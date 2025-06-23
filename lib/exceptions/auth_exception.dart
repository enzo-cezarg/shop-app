class AuthException implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_EXISTS': 'Email already in use.',
    'OPERATION_NOT_ALLOWED': '	Operation not allowed.',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Access temporarily blocked. Try again later.',
    'EMAIL_NOT_FOUND': 'Email not found.',
    'INVALID_PASSWORD': '	Incorrect password.',
    'INVALID_LOGIN_CREDENTIALS': 'Invalid email or password.',
    'USER_DISABLED': 'This user account has been disabled.',
  };

  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Authentication failed. Please try again.';
  }
}
