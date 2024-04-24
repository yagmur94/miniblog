abstract class ArticleEvent {} 

class FetchArticles extends ArticleEvent {} 

class AddArticle extends ArticleEvent {
  String title;
  String content;
  String author;
  String image;
  AddArticle({
    required this.title,
    required this.content,
    required this.author,
    required this.image,
  });
}