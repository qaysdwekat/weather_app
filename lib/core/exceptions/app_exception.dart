import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable {
  final String? message;

  const AppException({required this.message});

  @override
  List<Object?> get props => [message];
}
