import 'package:freezed_annotation/freezed_annotation.dart';

part 'async_task.freezed.dart';

@freezed
class AsyncTask<T> with _$AsyncTask {
  const factory AsyncTask.result(T result) = _AsyncTask;

  const factory AsyncTask.loading() = _AsyncTaskLogin;

  const factory AsyncTask.error(
      {@Default("Une erreur s'est produite") String message}) = _AsyncTaskError;
}
