import 'package:miniblog/models/blog.dart';

abstract class DetailState {}

class DetailInitial extends DetailState {}

class DetailLoaded extends DetailState {
  final Blog articlesId;
  DetailLoaded({required this.articlesId});
}

class DetailLoading extends DetailState {}

class DetailError extends DetailState {}