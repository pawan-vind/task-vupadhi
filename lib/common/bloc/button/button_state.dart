abstract class ButtonState {}

class ButtonInitialState extends ButtonState {}
class ButtonLoadingState extends ButtonState {}
class ButtonSuccessState extends ButtonState {}
class ButtonfailureState extends ButtonState {
  final String errorMessage;

  ButtonfailureState({required this.errorMessage});
}