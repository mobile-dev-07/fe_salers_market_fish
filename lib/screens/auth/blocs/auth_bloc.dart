import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gudang_market_fish/components/auth/domain/entities/auth_entity.dart';
import 'package:gudang_market_fish/components/auth/domain/usecases/login_usecase.dart';
import 'package:gudang_market_fish/components/auth/domain/usecases/logout_usecase.dart';

import '../../../components/auth/domain/usecases/register_usecase.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await loginUseCase(LoginParams(
      email: event.email,
      password: event.password,
    ));

    result.fold(
          (failure) => emit(AuthFailure(_mapFailureToMessage(failure))),
          (authEntity) => emit(AuthSuccess(authEntity)),
    );
  }

  Future<void> _onRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await registerUseCase(RegisterParams(
      name: event.name,
      email: event.email,
      phoneNumber: event.phoneNumber,
      password: event.password,
    ));

    result.fold(
          (failure) => emit(AuthFailure(_mapFailureToMessage(failure))),
          (authEntity) => emit(AuthSuccess(authEntity)),
    );
  }

  Future<void> _onLogoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    await logoutUseCase(NoParams());
    emit(AuthInitial());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      case NetworkFailure:
        return (failure as NetworkFailure).message;
      default:
        return 'Unexpected error';
    }
  }
}