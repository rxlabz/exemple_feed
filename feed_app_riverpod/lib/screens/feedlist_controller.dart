import 'package:feed_lib/feed_lib.dart';
import 'package:flutter/cupertino.dart';

class FeedController extends ChangeNotifier {
  final FeedService _service;

  FeedController({required FeedService service}) : _service = service;

  AsyncTask<List<Message>> _loadAllTask = const AsyncTask.result([]);

  AsyncTask<List<Message>> get loadAllTask => _loadAllTask;

  set loadAllTask(AsyncTask<List<Message>> loadAllTask) {
    _loadAllTask = loadAllTask;
    notifyListeners();
  }

  AsyncTask<Message?> _loadDetailsTask = const AsyncTask.result(null);

  AsyncTask<Message?> get loadDetailsTask => _loadDetailsTask;

  set loadDetailsTask(AsyncTask<Message?> loadDetailsTask) {
    _loadDetailsTask = loadDetailsTask;
    notifyListeners();
  }

  AsyncTask<Message?> _sendMessageTask = const AsyncTask.result(null);

  AsyncTask<Message?> get sendMessageTask => _sendMessageTask;

  set sendMessageTask(AsyncTask<Message?> sendMessageTask) {
    _sendMessageTask = sendMessageTask;
    notifyListeners();
  }

  Future<void> loadAllMessages() async {
    loadAllTask = const AsyncTask.loading();

    try {
      final result = await _service.loadAll();
      loadAllTask = AsyncTask.result(result);
    } catch (err) {
      loadAllTask = const AsyncTask.error();
    }
  }

  Future<void> loadMessage(int messageId) async {
    loadDetailsTask = const AsyncTask.loading();

    try {
      final result = await _service.loadMessage(messageId);
      loadDetailsTask = AsyncTask.result(result);
    } catch (err) {
      loadDetailsTask = const AsyncTask.error();
    }
  }

  Future<void> sendMessage(Message message) async {
    sendMessageTask = const AsyncTask.loading();

    try {
      final result = await _service.sendMessage(message);
      sendMessageTask = AsyncTask.result(result);
    } catch (err) {
      sendMessageTask = const AsyncTask.error();
    }
  }
}
