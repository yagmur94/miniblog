import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/details/detail_bloc.dart';
import 'package:miniblog/blocs/details/detail_event.dart';
import 'package:miniblog/models/blog.dart';
import 'package:miniblog/screens/detail.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.blog});

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<DetailBloc>().add(ResetDetailEvent());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetails(id: blog.id!),
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            AspectRatio(
                aspectRatio: 4 / 2, child: Image.network(blog.thumbnail!)),
            ListTile(
              title: Text(blog.title!),
              subtitle: Text(blog.author!),
            )
          ],
        ),
      ),
    );
  }
}