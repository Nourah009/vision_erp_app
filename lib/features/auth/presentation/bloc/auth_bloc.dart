import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_erp_app/core/di/injection_container.dart';
import 'package:vision_erp_app/core/logging/logger_service.dart';
import 'package:vision_erp_app/features/auth/domain/usecases/login.dart';
import 'package:vision_erp_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:vision_erp_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final LoggerService _logger = sl<LoggerService>();

  AuthBloc({required this.login}) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final failureOrUser = await login(LoginParams(email: event.email, password: event.password));
      failureOrUser.fold(
        (failure) {
          _logger.error('Login failed: $failure');
          emit(const AuthError(message: 'Invalid credentials'));
        },
        (user) {
          _logger.info('Login successful for user: ${user.name}');
          emit(AuthAuthenticated(user: user));
        },
      );
    });
  }
}
