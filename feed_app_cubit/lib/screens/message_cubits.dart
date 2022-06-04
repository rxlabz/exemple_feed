import 'package:bloc/bloc.dart';
import 'package:feed_lib/feed_lib.dart';

class HomeCubit extends Cubit<AsyncTask<List<Message>>> {
  final FeedService _service;

  HomeCubit(this._service) : super(const AsyncTask<List<Message>>.result([]));

  Future<void> loadAll() async {
    emit(const AsyncTask.loading());

    try {
      final result = await _service.loadAll();
      emit(AsyncTask.result(result));
    } catch (err) {
      emit(const AsyncTask.error());
    }
  }
}

class MessageCubit extends Cubit<AsyncTask<Message?>> {
  final FeedService _service;

  MessageCubit(this._service)
      : super(const AsyncTask<Message?>.result(null));

  Future<void> loadMessage(int messageId) async {
    emit(const AsyncTask.loading());

    try {
      final result = await _service.loadMessage(messageId);
      emit(AsyncTask.result(result));
    } catch (err) {
      emit(const AsyncTask.error());
    }
  }
}

class SendMessageCubit extends Cubit<AsyncTask<Message?>> {
  final FeedService _service;

  SendMessageCubit(this._service)
      : super(const AsyncTask<Message?>.result(null));

  Future<void> sendMessage(Message message) async {
    emit(const AsyncTask.loading());

    try {
      final result = await _service.sendMessage(message);
      emit(AsyncTask.result(result));
    } catch (err) {
      emit(const AsyncTask.error());
    }
  }
}
