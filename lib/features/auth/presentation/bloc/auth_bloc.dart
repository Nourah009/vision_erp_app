import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_erp_app/features/auth/domain/usecases/login.dart';
import 'package:vision_erp_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:vision_erp_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;

  AuthBloc({required this.login}) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final failureOrUser = await login(LoginParams(email: event.email, password: event.password));
      failureOrUser.fold(
        (failure) => emit(const AuthError(message: 'Invalid credentials')),
        (user) => emit(AuthAuthenticated(user: user)),
      );
    });
  }
}
