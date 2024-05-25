
abstract class BaseApiExcepiton implements Exception {
  final String errorMessage;
  final String erorPrefix;
  BaseApiExcepiton({required this.erorPrefix, required this.errorMessage});
  @override
  String toString(){
    return "$erorPrefix $errorMessage";
  }
}
