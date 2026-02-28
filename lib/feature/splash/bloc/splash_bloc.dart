import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpsmapiot/feature/splash/bloc/splash_event.dart';
import 'package:gpsmapiot/feature/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState>{
  SplashBloc() : super(SplashInitial()){
    on<SplashStarted>(_onStarted);
  }

  Future<void> _onStarted(
      SplashStarted event,
      Emitter<SplashState> emit,
      ) async {
    await Future.delayed(const Duration(microseconds: 1200));
    emit(SplashSendToScreen());
  }

}