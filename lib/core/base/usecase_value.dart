import 'package:equatable/equatable.dart';

import '../exceptions/app_exception.dart';


sealed class UsecaseValue<T> {
  factory UsecaseValue.success(T result) = UsecaseSuccess<T>;

  factory UsecaseValue.exception(AppException exception) = AppFailureException;
}

class UsecaseSuccess<T> extends Equatable implements UsecaseValue<T> {
  final T result;
  const UsecaseSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class AppFailureException<T> extends Equatable implements UsecaseValue<T> {
  final AppException exception;
  const AppFailureException(this.exception);

  @override
  List<Object?> get props => [exception];
}