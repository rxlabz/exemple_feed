// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      id: json['id'] as int?,
      name: json['name'] as String,
      message: json['message'] as String,
      date: DateTime.parse(json['date'] as String),
      replies: (json['replies'] as List<dynamic>?)
          ?.map((e) => Reply.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'message': instance.message,
      'date': instance.date.toIso8601String(),
      'replies': instance.replies,
    };

_$_Reply _$$_ReplyFromJson(Map<String, dynamic> json) => _$_Reply(
      id: json['id'] as int,
      messageId: json['messageId'] as int,
      message: json['message'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_ReplyToJson(_$_Reply instance) => <String, dynamic>{
      'id': instance.id,
      'messageId': instance.messageId,
      'message': instance.message,
      'name': instance.name,
    };
