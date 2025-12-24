import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vision_erp_app/core/error/failures.dart';
import 'package:vision_erp_app/core/usecases/usecase.dart';
import 'package:vision_erp_app/features/auth/domain/entities/user.dart';
import 'package:vision_erp_app/features/auth/domain/repositories/auth_repository.dart';

class Login implements UseCase<User, LoginParams> {
  final AuthRepository repository;

  Login(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
