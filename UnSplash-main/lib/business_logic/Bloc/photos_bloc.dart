import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../data/models/image_model.dart';
import '../../data/repository/get_images.dart';

part 'photos_event.dart';
part 'photos_state.dart';

const throttleDuration = Duration(milliseconds: 100);
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
 final GetImages getImages;

  PhotoBloc({required this.getImages,})
      : super(const PhotoState()) {
    on<PhotoFetched>(
      _onPhotoFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

 // List<ImageModel> imageModel;
  Future<void> _onPhotoFetched(PhotoFetched event, Emitter<PhotoState> emit,) async {

    try {
      if (state.hasReachedMax) return;
      if (state.status == PhotoStatus.initial) {
        List<ImageModel> images= await getImages.getAllImages(1,20);
        return emit(state.copyWith(
          status: PhotoStatus.success,
          photos: images,
          hasReachedMax: false,
        ),
        );
      }

      if (state.status == PhotoStatus.success) {
        List<ImageModel> images = await getImages.getAllImages(1,20);
        images.isEmpty
            ? emit(state.copyWith(
            status: PhotoStatus.success,
            photos: images,
            hasReachedMax: true))
            : emit(
          state.copyWith(
            status: PhotoStatus.success,
            photos: List.of(state.photos)..addAll(images),
            hasReachedMax: false,
          ),
        );
      }
    } catch (error) {
      emit(state.copyWith(status: PhotoStatus.failure));
    }
  }
}