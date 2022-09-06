import 'package:xafe/features/authentication/controllers/auth_exception_firebase_handler.dart';
import 'package:xafe/utils/custom_error_alert.dart';

class ErrorController {
  void handleError(error, context) {
    if (error is ApiNotRespondingException) {
      showCustomErrorDialog(context,
          'Oops! It took longer to respond. Check your internet connection and try again');
    } 
    // else if (error is NetworkConnectionException) {
    //   showCustomErrorDialog(
    //       context, 'Check your internet connection and try again');
    // }
  }
}
