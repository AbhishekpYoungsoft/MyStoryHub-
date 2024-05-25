import 'package:bloc/bloc.dart';
import 'package:mystoryhub/business_logic/blocs/landing_bloc.dart/events.dart';
import 'package:mystoryhub/business_logic/blocs/landing_bloc.dart/states.dart';

class LandingBloc extends Bloc<LandingEvents,LandingStates>{
 LandingBloc():super(LandingLoadedState(0)){
    on<UpdateBottomNavItemEventItem>((event, emit) => updateBottomNavItemEventItem(event, emit));
  }
  
  updateBottomNavItemEventItem(UpdateBottomNavItemEventItem event, Emitter<LandingStates> emit) {
     emit(LandingLoadedState(event.index));
  }
  
}