import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miniblog/blocs/articles/article_bloc.dart';
import 'package:miniblog/blocs/articles/article_event.dart';
import 'package:miniblog/blocs/themes/theme_bloc.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;
  String title = '';
  String content = '';
  String author = '';

  void openImagePicker(ImageSource source) async {
    XFile? selectedFile = await _picker.pickImage(source: source);
    setState(() {
      selectedImage = selectedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: Builder(
        builder: (context) {
          final themeBloc = BlocProvider.of<ThemeBloc>(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(133, 94, 3, 1),
              title: const Text(
                "Blog Ekle",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    if (selectedImage != null)
                      Image.file(
                        File(selectedImage!.path),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.fitHeight,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            openImagePicker(ImageSource.gallery);
                          },
                          child: const Text(
                            "Galeriden Seç",
                            style: TextStyle(
                                color: Color.fromARGB(133, 94, 3, 1)),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            openImagePicker(ImageSource.camera);
                          },
                          child: const Text("Fotoğraf Çek",
                              style: TextStyle(
                                  color: Color.fromARGB(133, 94, 3, 1))),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Blog Başlığı"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Lütfen Başlık Giriniz";
                        }
                        return null;
                      },
                      onSaved: (newValue) => title = newValue!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Blog İçeriği"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Lütfen Blog İçeriği Giriniz";
                        }
                        return null;
                      },
                      onSaved: (newValue) => content = newValue!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Ad Soyad"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Lütfen Ad Soyad Giriniz";
                        }
                        return null;
                      },
                      onSaved: (newValue) => author = newValue!,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (selectedImage == null) {
                            return;
                          }

                          _formKey.currentState!.save();
                          context.read<ArticleBloc>().add(AddArticle(
                              title: title,
                              content: content,
                              author: author,
                              image: selectedImage!.path));
                          Navigator.pop(context, true);
                        }
                      },
                      child: const Text(
                        "Gönder",
                        style: TextStyle(
                            color: Color.fromARGB(133, 94, 3, 1)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

