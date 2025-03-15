import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/users/domain/use_case/get_users_use_case.dart';
import 'package:storeapp/app/users/domain/use_case/add_user_use_case.dart';
import 'package:storeapp/app/users/presentation/bloc/user_event.dart';
import 'package:storeapp/app/users/presentation/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersUseCase getUsersUseCase;

  UserBloc({required this.getUsersUseCase}) : super(UserLoadingState()) {
    on<GetUsersEvent>(_getUsers);
  }

  void _getUsers(GetUsersEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      final users = await getUsersUseCase.call();
      emit(UserLoadedState(users: users));
    } catch (e) {
      emit(UserErrorState(message: "Error al obtener usuarios"));
    }
  }
}
