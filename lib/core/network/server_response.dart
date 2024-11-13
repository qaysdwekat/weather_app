import 'dart:convert';

import 'package:equatable/equatable.dart';
 
import '../exceptions/server_exception.dart';

class ServerResponse<T> extends Equatable {
  final T? data;

  final int? statusCode;

  final String? statusMessage;

  final ServerResponseType? type;

  const ServerResponse({
    this.data,
    this.statusCode,
    this.statusMessage,
    this.type,
  });

  @override
  List<Object?> get props => [
        this.data,
        this.statusCode,
        this.statusMessage,
      ];

  bool get ok {
    return ((statusCode ?? 0) ~/ 100) == 2;
  }

  ServerResponse copyWith({
    T? data,
    int? statusCode,
    String? statusMessage,
    ServerResponseType? type,
  }) =>
      ServerResponse(
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
        statusMessage: statusMessage ?? this.statusMessage,
        type: type ?? this.type,
      );

  dynamic getData() {
    if (this.ok) {
      if (data is String) {
        return jsonDecode(this.data as String);
      }

      return this.data;
    }

    switch (statusCode) {
      default:
        throw ServerException(message: this.statusMessage);
    }
  }
}

enum ServerResponseType {
  error,
  timeout,
  success,
  progress,
  connectionError,
}
