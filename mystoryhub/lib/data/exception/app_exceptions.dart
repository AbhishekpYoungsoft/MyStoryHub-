
import 'package:mystoryhub/data/exception/base_exceptions.dart';

class SocketException extends BaseApiExcepiton{
  SocketException(String errorMessage): super(erorPrefix: "Failed to make connection",errorMessage: errorMessage);
}

class BadRequestException extends BaseApiExcepiton{
  BadRequestException(String errorMessage): super(erorPrefix: "Invalid request",errorMessage: errorMessage);
}

class UnAuthorizedException extends BaseApiExcepiton{
  UnAuthorizedException(String errorMessage): super(erorPrefix: "Unauthorized request", errorMessage: errorMessage);

}
class InValidInputException extends BaseApiExcepiton{
  InValidInputException(String errorMessage):super(erorPrefix: "Unauthorized request",errorMessage: errorMessage);
}