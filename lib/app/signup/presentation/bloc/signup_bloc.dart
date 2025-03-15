import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/signup/domain/use_case/signup_use_case.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_event.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;

  SignUpBloc({required this.signUpUseCase}) : super(InitialSignUpState()) {
    on<SubmitSignUpEvent>(_submitSignUpEvent);
    on<EmailChangedEvent>(_emailChangedEvent);
  }

  void _emailChangedEvent(EmailChangedEvent event, Emitter<SignUpState> emit) {
    final newState =
        DataUpdateState(model: state.model.copyWith(email: event.email));

    emit(newState);
  }

  void _submitSignUpEvent(
      SubmitSignUpEvent event, Emitter<SignUpState> emit) async {
    emit(LoadingSignUpState(model: state.model));

    final bool result = await signUpUseCase.invoke(event.signupEntity);

    if (result) {
      emit(SuccessSignUpState(model: state.model));
    } else {
      emit(ErrorSignUpState(
          model: state.model, message: "Error al registrar usuario"));
    }
  }
}
