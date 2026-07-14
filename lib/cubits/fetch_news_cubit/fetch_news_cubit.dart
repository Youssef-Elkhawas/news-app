import 'package:bloc/bloc.dart';
import 'package:news_app/cubits/fetch_news_cubit/fetch_news_state.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/fetch_news_service.dart';

class FetchNewsCubit extends Cubit<FetchNewsState> {
  FetchNewsCubit() : super(FetchNewsInitialState());

  FetchNewsService fetchNewsService = FetchNewsService();
  List<NewsModel> newsList = [];

  Future<void> fetchNews({required String category}) async {
    emit(FetchNewsLoading());
    try {
      newsList = await fetchNewsService.newsList(category: category);
      emit(FetchNewsSuccess());
    } catch (e) {
      print(e.toString());
      emit(FetchNewsFailed());
    }
  }
}
