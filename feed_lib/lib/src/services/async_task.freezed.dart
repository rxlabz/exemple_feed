// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'async_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AsyncTaskTearOff {
  const _$AsyncTaskTearOff();

  _AsyncTask<T> result<T>(T result) {
    return _AsyncTask<T>(
      result,
    );
  }

  _AsyncTaskLogin<T> loading<T>() {
    return _AsyncTaskLogin<T>();
  }

  _AsyncTaskError<T> error<T>({String message = "Une erreur s'est produite"}) {
    return _AsyncTaskError<T>(
      message: message,
    );
  }
}

/// @nodoc
const $AsyncTask = _$AsyncTaskTearOff();

/// @nodoc
mixin _$AsyncTask<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T result) result,
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T result)? result,
    TResult Function()? loading,
    TResult Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T result)? result,
    TResult Function()? loading,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AsyncTask<T> value) result,
    required TResult Function(_AsyncTaskLogin<T> value) loading,
    required TResult Function(_AsyncTaskError<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AsyncTask<T> value)? result,
    TResult Function(_AsyncTaskLogin<T> value)? loading,
    TResult Function(_AsyncTaskError<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AsyncTask<T> value)? result,
    TResult Function(_AsyncTaskLogin<T> value)? loading,
    TResult Function(_AsyncTaskError<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AsyncTaskCopyWith<T, $Res> {
  factory $AsyncTaskCopyWith(
          AsyncTask<T> value, $Res Function(AsyncTask<T>) then) =
      _$AsyncTaskCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$AsyncTaskCopyWithImpl<T, $Res> implements $AsyncTaskCopyWith<T, $Res> {
  _$AsyncTaskCopyWithImpl(this._value, this._then);

  final AsyncTask<T> _value;
  // ignore: unused_field
  final $Res Function(AsyncTask<T>) _then;
}

/// @nodoc
abstract class _$AsyncTaskCopyWith<T, $Res> {
  factory _$AsyncTaskCopyWith(
          _AsyncTask<T> value, $Res Function(_AsyncTask<T>) then) =
      __$AsyncTaskCopyWithImpl<T, $Res>;
  $Res call({T result});
}

/// @nodoc
class __$AsyncTaskCopyWithImpl<T, $Res> extends _$AsyncTaskCopyWithImpl<T, $Res>
    implements _$AsyncTaskCopyWith<T, $Res> {
  __$AsyncTaskCopyWithImpl(
      _AsyncTask<T> _value, $Res Function(_AsyncTask<T>) _then)
      : super(_value, (v) => _then(v as _AsyncTask<T>));

  @override
  _AsyncTask<T> get _value => super._value as _AsyncTask<T>;

  @override
  $Res call({
    Object? result = freezed,
  }) {
    return _then(_AsyncTask<T>(
      result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_AsyncTask<T> implements _AsyncTask<T> {
  const _$_AsyncTask(this.result);

  @override
  final T result;

  @override
  String toString() {
    return 'AsyncTask<$T>.result(result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AsyncTask<T> &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  _$AsyncTaskCopyWith<T, _AsyncTask<T>> get copyWith =>
      __$AsyncTaskCopyWithImpl<T, _AsyncTask<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T result) result,
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) {
    return result(this.result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T result)? result,
    TResult Function()? loading,
    TResult Function(String message)? error,
  }) {
    return result?.call(this.result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T result)? result,
    TResult Function()? loading,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (result != null) {
      return result(this.result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AsyncTask<T> value) result,
    required TResult Function(_AsyncTaskLogin<T> value) loading,
    required TResult Function(_AsyncTaskError<T> value) error,
  }) {
    return result(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AsyncTask<T> value)? result,
    TResult Function(_AsyncTaskLogin<T> value)? loading,
    TResult Function(_AsyncTaskError<T> value)? error,
  }) {
    return result?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AsyncTask<T> value)? result,
    TResult Function(_AsyncTaskLogin<T> value)? loading,
    TResult Function(_AsyncTaskError<T> value)? error,
    required TResult orElse(),
  }) {
    if (result != null) {
      return result(this);
    }
    return orElse();
  }
}

abstract class _AsyncTask<T> implements AsyncTask<T> {
  const factory _AsyncTask(T result) = _$_AsyncTask<T>;

  T get result;
  @JsonKey(ignore: true)
  _$AsyncTaskCopyWith<T, _AsyncTask<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$AsyncTaskLoginCopyWith<T, $Res> {
  factory _$AsyncTaskLoginCopyWith(
          _AsyncTaskLogin<T> value, $Res Function(_AsyncTaskLogin<T>) then) =
      __$AsyncTaskLoginCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$AsyncTaskLoginCopyWithImpl<T, $Res>
    extends _$AsyncTaskCopyWithImpl<T, $Res>
    implements _$AsyncTaskLoginCopyWith<T, $Res> {
  __$AsyncTaskLoginCopyWithImpl(
      _AsyncTaskLogin<T> _value, $Res Function(_AsyncTaskLogin<T>) _then)
      : super(_value, (v) => _then(v as _AsyncTaskLogin<T>));

  @override
  _AsyncTaskLogin<T> get _value => super._value as _AsyncTaskLogin<T>;
}

/// @nodoc

class _$_AsyncTaskLogin<T> implements _AsyncTaskLogin<T> {
  const _$_AsyncTaskLogin();

  @override
  String toString() {
    return 'AsyncTask<$T>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _AsyncTaskLogin<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T result) result,
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T result)? result,
    TResult Function()? loading,
    TResult Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T result)? result,
    TResult Function()? loading,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AsyncTask<T> value) result,
    required TResult Function(_AsyncTaskLogin<T> value) loading,
    required TResult Function(_AsyncTaskError<T> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AsyncTask<T> value)? result,
    TResult Function(_AsyncTaskLogin<T> value)? loading,
    TResult Function(_AsyncTaskError<T> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AsyncTask<T> value)? result,
    TResult Function(_AsyncTaskLogin<T> value)? loading,
    TResult Function(_AsyncTaskError<T> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _AsyncTaskLogin<T> implements AsyncTask<T> {
  const factory _AsyncTaskLogin() = _$_AsyncTaskLogin<T>;
}

/// @nodoc
abstract class _$AsyncTaskErrorCopyWith<T, $Res> {
  factory _$AsyncTaskErrorCopyWith(
          _AsyncTaskError<T> value, $Res Function(_AsyncTaskError<T>) then) =
      __$AsyncTaskErrorCopyWithImpl<T, $Res>;
  $Res call({String message});
}

/// @nodoc
class __$AsyncTaskErrorCopyWithImpl<T, $Res>
    extends _$AsyncTaskCopyWithImpl<T, $Res>
    implements _$AsyncTaskErrorCopyWith<T, $Res> {
  __$AsyncTaskErrorCopyWithImpl(
      _AsyncTaskError<T> _value, $Res Function(_AsyncTaskError<T>) _then)
      : super(_value, (v) => _then(v as _AsyncTaskError<T>));

  @override
  _AsyncTaskError<T> get _value => super._value as _AsyncTaskError<T>;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_AsyncTaskError<T>(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AsyncTaskError<T> implements _AsyncTaskError<T> {
  const _$_AsyncTaskError({this.message = "Une erreur s'est produite"});

  @JsonKey()
  @override
  final String message;

  @override
  String toString() {
    return 'AsyncTask<$T>.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AsyncTaskError<T> &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$AsyncTaskErrorCopyWith<T, _AsyncTaskError<T>> get copyWith =>
      __$AsyncTaskErrorCopyWithImpl<T, _AsyncTaskError<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T result) result,
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T result)? result,
    TResult Function()? loading,
    TResult Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T result)? result,
    TResult Function()? loading,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AsyncTask<T> value) result,
    required TResult Function(_AsyncTaskLogin<T> value) loading,
    required TResult Function(_AsyncTaskError<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AsyncTask<T> value)? result,
    TResult Function(_AsyncTaskLogin<T> value)? loading,
    TResult Function(_AsyncTaskError<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AsyncTask<T> value)? result,
    TResult Function(_AsyncTaskLogin<T> value)? loading,
    TResult Function(_AsyncTaskError<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _AsyncTaskError<T> implements AsyncTask<T> {
  const factory _AsyncTaskError({String message}) = _$_AsyncTaskError<T>;

  String get message;
  @JsonKey(ignore: true)
  _$AsyncTaskErrorCopyWith<T, _AsyncTaskError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
