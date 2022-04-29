// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
class _$MessageTearOff {
  const _$MessageTearOff();

  _Message call(
      {int? id,
      required String name,
      required String message,
      required DateTime date,
      List<Reply>? replies}) {
    return _Message(
      id: id,
      name: name,
      message: message,
      date: date,
      replies: replies,
    );
  }

  Message fromJson(Map<String, Object?> json) {
    return Message.fromJson(json);
  }
}

/// @nodoc
const $Message = _$MessageTearOff();

/// @nodoc
mixin _$Message {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  List<Reply>? get replies => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      String name,
      String message,
      DateTime date,
      List<Reply>? replies});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res> implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  final Message _value;
  // ignore: unused_field
  final $Res Function(Message) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? message = freezed,
    Object? date = freezed,
    Object? replies = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      replies: replies == freezed
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<Reply>?,
    ));
  }
}

/// @nodoc
abstract class _$MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$MessageCopyWith(_Message value, $Res Function(_Message) then) =
      __$MessageCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      String name,
      String message,
      DateTime date,
      List<Reply>? replies});
}

/// @nodoc
class __$MessageCopyWithImpl<$Res> extends _$MessageCopyWithImpl<$Res>
    implements _$MessageCopyWith<$Res> {
  __$MessageCopyWithImpl(_Message _value, $Res Function(_Message) _then)
      : super(_value, (v) => _then(v as _Message));

  @override
  _Message get _value => super._value as _Message;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? message = freezed,
    Object? date = freezed,
    Object? replies = freezed,
  }) {
    return _then(_Message(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      replies: replies == freezed
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<Reply>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Message implements _Message {
  const _$_Message(
      {this.id,
      required this.name,
      required this.message,
      required this.date,
      this.replies});

  factory _$_Message.fromJson(Map<String, dynamic> json) =>
      _$$_MessageFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  final String message;
  @override
  final DateTime date;
  @override
  final List<Reply>? replies;

  @override
  String toString() {
    return 'Message(id: $id, name: $name, message: $message, date: $date, replies: $replies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Message &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality().equals(other.replies, replies));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(replies));

  @JsonKey(ignore: true)
  @override
  _$MessageCopyWith<_Message> get copyWith =>
      __$MessageCopyWithImpl<_Message>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageToJson(this);
  }
}

abstract class _Message implements Message {
  const factory _Message(
      {int? id,
      required String name,
      required String message,
      required DateTime date,
      List<Reply>? replies}) = _$_Message;

  factory _Message.fromJson(Map<String, dynamic> json) = _$_Message.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  String get message;
  @override
  DateTime get date;
  @override
  List<Reply>? get replies;
  @override
  @JsonKey(ignore: true)
  _$MessageCopyWith<_Message> get copyWith =>
      throw _privateConstructorUsedError;
}

Reply _$ReplyFromJson(Map<String, dynamic> json) {
  return _Reply.fromJson(json);
}

/// @nodoc
class _$ReplyTearOff {
  const _$ReplyTearOff();

  _Reply call(
      {required int id,
      required int messageId,
      required String message,
      required String name}) {
    return _Reply(
      id: id,
      messageId: messageId,
      message: message,
      name: name,
    );
  }

  Reply fromJson(Map<String, Object?> json) {
    return Reply.fromJson(json);
  }
}

/// @nodoc
const $Reply = _$ReplyTearOff();

/// @nodoc
mixin _$Reply {
  int get id => throw _privateConstructorUsedError;
  int get messageId => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReplyCopyWith<Reply> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReplyCopyWith<$Res> {
  factory $ReplyCopyWith(Reply value, $Res Function(Reply) then) =
      _$ReplyCopyWithImpl<$Res>;
  $Res call({int id, int messageId, String message, String name});
}

/// @nodoc
class _$ReplyCopyWithImpl<$Res> implements $ReplyCopyWith<$Res> {
  _$ReplyCopyWithImpl(this._value, this._then);

  final Reply _value;
  // ignore: unused_field
  final $Res Function(Reply) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? messageId = freezed,
    Object? message = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      messageId: messageId == freezed
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as int,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ReplyCopyWith<$Res> implements $ReplyCopyWith<$Res> {
  factory _$ReplyCopyWith(_Reply value, $Res Function(_Reply) then) =
      __$ReplyCopyWithImpl<$Res>;
  @override
  $Res call({int id, int messageId, String message, String name});
}

/// @nodoc
class __$ReplyCopyWithImpl<$Res> extends _$ReplyCopyWithImpl<$Res>
    implements _$ReplyCopyWith<$Res> {
  __$ReplyCopyWithImpl(_Reply _value, $Res Function(_Reply) _then)
      : super(_value, (v) => _then(v as _Reply));

  @override
  _Reply get _value => super._value as _Reply;

  @override
  $Res call({
    Object? id = freezed,
    Object? messageId = freezed,
    Object? message = freezed,
    Object? name = freezed,
  }) {
    return _then(_Reply(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      messageId: messageId == freezed
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as int,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Reply implements _Reply {
  const _$_Reply(
      {required this.id,
      required this.messageId,
      required this.message,
      required this.name});

  factory _$_Reply.fromJson(Map<String, dynamic> json) =>
      _$$_ReplyFromJson(json);

  @override
  final int id;
  @override
  final int messageId;
  @override
  final String message;
  @override
  final String name;

  @override
  String toString() {
    return 'Reply(id: $id, messageId: $messageId, message: $message, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Reply &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.messageId, messageId) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(messageId),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$ReplyCopyWith<_Reply> get copyWith =>
      __$ReplyCopyWithImpl<_Reply>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReplyToJson(this);
  }
}

abstract class _Reply implements Reply {
  const factory _Reply(
      {required int id,
      required int messageId,
      required String message,
      required String name}) = _$_Reply;

  factory _Reply.fromJson(Map<String, dynamic> json) = _$_Reply.fromJson;

  @override
  int get id;
  @override
  int get messageId;
  @override
  String get message;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$ReplyCopyWith<_Reply> get copyWith => throw _privateConstructorUsedError;
}
