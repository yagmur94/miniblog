import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/details/detail_bloc.dart';
import 'package:miniblog/blocs/details/detail_event.dart';
import 'package:miniblog/blocs/details/detail_state.dart';

class BlogDetails extends StatefulWidget {
  const BlogDetails({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  _BlogDetailsState createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        if (state is DetailInitial) {
          context.read<DetailBloc>().add(FetchDetailsId(blogId: widget.id));
          return const Center(
            child: CircularProgressIndicator(), 
          );
        }
        if (state is DetailLoading) {
          return const Center(
            child: CircularProgressIndicator(), 
          );
        }
        if (state is DetailLoaded) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(133, 94, 3, 1),
              title: Text(state.articlesId.title!), 
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    state.articlesId.thumbnail!, 
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Yazar: ${state.articlesId.author!}",
                    style: TextStyle(
                      color: Colors.grey[600], 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        state.articlesId.content!, 
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is DetailError) {
          return const Center(
            child: Text(
              "Hata Alındı!",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(133, 94, 3, 1),
              ),
            ),
          );
        }
        return const Center(
          child: Text(
            "Veri Alınamadı!",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Color.fromARGB(133, 94, 3, 1),
            ),
          ),
        );
      },
    );
  }
}
