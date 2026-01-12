import 'package:dartz/dartz.dart';
import 'package:vision_erp_app/core/error/failures.dart';
import 'package:vision_erp_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
}
