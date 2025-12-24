import 'package:dartz/dartz.dart';
import 'package:vision_erp_app/core/error/failures.dart';
import 'package:vision_erp_app/core/network/network_info.dart';
import 'package:vision_erp_app/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:vision_erp_app/features/auth/domain/entities/user.dart';
import 'package:vision_erp_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.login(email, password);
        return Right(remoteUser);
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
