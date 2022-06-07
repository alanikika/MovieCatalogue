import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/presentation/bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int currentIndex = 0;

  HomeBloc(HomeState initialState) : super(PageLoading());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    //Initial app menu
    if (event is MovieStarted) {
      add(PageTapped(index: 0));
    }
    //Menu tapped
    if (event is PageTapped) {
      currentIndex = event.index;
      yield CurrentIndexChanged(currentIndex: currentIndex);
      yield PageLoading();

      if (currentIndex == 0) {
        yield MoviePageLoaded();
      } else if (currentIndex == 1) {
        yield TvPageLoaded();
      } else if (currentIndex == 2) {
        yield ProfilePageLoaded();
      }
    }
  }
}
