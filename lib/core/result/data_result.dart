import 'package:patient_project/core/error/app_exception.dart';

abstract class DataResult<T> {
  const DataResult();
}

class Success<T> extends DataResult<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends DataResult<T> {
  final AppException exception;
  const Failure(this.exception);
}
