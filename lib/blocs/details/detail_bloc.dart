import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/details/detail_event.dart';
import 'package:miniblog/blocs/details/detail_state.dart';
import 'package:miniblog/repositories/article_repository.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final ArticleRepository articleRepository;

  DetailBloc({required this.articleRepository})
      : super(DetailInitial()) {
    on<FetchDetailsId>(_onFetchDetailsId);
    on<ResetDetailEvent>(_onResetDetailsId);
    on<DeleteDetailEvent>(_onDeleteDetailsId);
  }

  void _onFetchDetailsId(
      FetchDetailsId event, Emitter<DetailState> emit) async {
    final String? blogID = event.blogId;
    emit(DetailLoading());

    try {
      final articlesId = await articleRepository.fetchArticleId(blogID!);
      emit(DetailLoaded(articlesId: articlesId));
    } catch (e) {
      emit(DetailError());
    }
  }

  void _onResetDetailsId(
      ResetDetailEvent event, Emitter<DetailState> emit) async {
    emit(DetailInitial());
  }

  void _onDeleteDetailsId(
      DeleteDetailEvent event, Emitter<DetailState> emit) async {
    final String blogID = event.blogId;

    try {
      await articleRepository.fetchDeleteBlogsId(blogID);
    } catch (e) {
      emit(DetailError());
    }
  }
}