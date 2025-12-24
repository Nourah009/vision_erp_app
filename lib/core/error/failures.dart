import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

/// A failure is an object that represents a failure in the application.
abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
}

/// General failures
class ServerFailure extends Failure {
  @override
  List<Object> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => [];
}
