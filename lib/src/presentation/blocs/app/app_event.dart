part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class UpdateAppLightEvent extends AppEvent {
  final bool isLightTheme;
  const UpdateAppLightEvent({required this.isLightTheme});
  @override
  List<Object> get props => [isLightTheme];
}
