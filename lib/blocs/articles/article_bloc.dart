import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/articles/article_event.dart';
import 'package:miniblog/blocs/articles/article_state.dart';
import 'package:miniblog/repositories/article_repository.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;


  ArticleBloc({required this.articleRepository}) : super(ArticlesInitial()) {
  
    on<FetchArticles>(_onFetchArticles); 
    on<AddArticle>(_onAddArticle);
  }

  void _onFetchArticles(FetchArticles event, Emitter<ArticleState> emit) async {
    
    emit(ArticlesLoading());

    try {
      final articles = await articleRepository.fetchAll();

      emit(ArticlesLoaded(
          blogs: articles)); 
    } catch (e) {
      emit(ArticlesError());
    }
  }

  void _onAddArticle(AddArticle event, Emitter<ArticleState> emit) async {
    try {
      await articleRepository.postArticle(event.title, event.content, event.author, event.image);
    } catch (e) {
      emit(ArticlesError());
    }
  }
}
