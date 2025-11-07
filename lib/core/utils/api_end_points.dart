class ApiEndPoints {
  static const String baseUrl = 'https://apis.namasteaylesbury.com';

  static const String signup = '$baseUrl/auth/signup';
  static const String login = '$baseUrl/auth/signin';
  static const String forgotPassword = '$baseUrl/auth/forgot-password';
  static const String resetPassword = '$baseUrl/auth/reset-password';
  static const String refreshToken = '$baseUrl/auth/refresh';
  static const String getuser = '$baseUrl/users/profile';
  static const String productList = '$baseUrl/products/';
  static const String subProductList = '$baseUrl/sub_products/';
  static const String address = '$baseUrl/addresses/';

  static const String placeorder = '$baseUrl/orders/';
  static const String logout = '$baseUrl/auth/logout';
  static const String orderhistory = '$baseUrl/orders/history';
}
