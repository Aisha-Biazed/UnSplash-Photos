part of 'photos_bloc.dart';

@immutable
enum PhotoStatus { initial, success, failure }

class PhotoState extends Equatable {
  const PhotoState({
    this.status = PhotoStatus.initial,
    this.photos = const <ImageModel>[],
    this.hasReachedMax = false,
  });

  final PhotoStatus status;
  final List<ImageModel> photos;
  final bool hasReachedMax;

  PhotoState copyWith({
    PhotoStatus? status,
    List<ImageModel>? photos,
    bool? hasReachedMax,
  }) {
    return PhotoState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PhotoState { status: $status, hasReachedMax: $hasReachedMax, photos: ${photos.length} }''';
  }

  @override
  List<Object> get props => [status, photos, hasReachedMax];
}
