import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/articles/article_bloc.dart';
import 'package:miniblog/blocs/articles/article_event.dart';
import 'package:miniblog/blocs/articles/article_state.dart';
import 'package:miniblog/blocs/themes/dark_theme.dart';
import 'package:miniblog/blocs/themes/light_theme.dart';
import 'package:miniblog/models/blog.dart';
import 'package:miniblog/screens/add_blog.dart';
import 'package:miniblog/widgets/blog_card.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Blog> blogs = [];
  bool isDarkTheme = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkTheme ? darkTheme : lightTheme,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(133, 94, 3, 1),
          title: const Text(
            "Anasayfa",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isDarkTheme = !isDarkTheme;
                });
              },
              icon: Icon(isDarkTheme ? Icons.wb_sunny : Icons.nightlight_round),
            ),
            IconButton(
              onPressed: () async {
                bool? result = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const AddBlog()),
                );
                if (result == true) {
                  context.read<ArticleBloc>().add(FetchArticles());
                }
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: Center(
          child: BlocBuilder<ArticleBloc, ArticleState>(
            builder: (context, state) {
              if (state is ArticlesInitial) {
                context.read<ArticleBloc>().add(FetchArticles());
                return const Center(
                  child: Text("İstek atılıyor..."),
                );
              }

              if (state is ArticlesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is ArticlesLoaded) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<ArticleBloc>().add(FetchArticles());
                  },
                  child: ListView.builder(
                      itemCount: state.blogs.length,
                      itemBuilder: (context, index) =>
                          BlogCard(blog: state.blogs[index])),
                );
              }

              if (state is ArticlesError) {
                return const Center(
                  child: Text("İçerik yüklenirken hata oluştu!"),
                );
              }

              return const Center(
                child: Text("Bilinmeyen Durum"),
              );
            },
          ),
        ),
      ),
    );
  }
}
