import 'package:feed_lib/feed_lib.dart';

final now = DateTime(2022);

final fakeMessage = Message(id: 1, name: 'Joe', message: 'Hola', date: now);
final fakeMessage2 = Message(id: 2, name: 'Bob', message: 'Salut', date: now);

final fakeMessageWithReplies = Message(
  id: 1,
  name: 'Joe',
  message: 'Hola',
  date: now,
  replies: List.generate(
    4,
    (index) => Reply(
      id: index,
      messageId: 1,
      message: 'ABCDE',
      name: 'User$index',
    ),
  ),
);

const fakeUser =
    User(id: 1, name: 'Joe', mail: 'joe@mail.com', token: 'XYZ12345678');

final messages = [fakeMessage];
