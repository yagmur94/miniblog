abstract class DetailEvent {}

class FetchDetailsId extends DetailEvent {
  final String? blogId;

  FetchDetailsId({required this.blogId});
}

class ResetDetailEvent extends DetailEvent {}

class DeleteDetailEvent extends DetailEvent {
  final String blogId;

  DeleteDetailEvent({required this.blogId});
}