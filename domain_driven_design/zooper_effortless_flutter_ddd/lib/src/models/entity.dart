import 'package:zooper_effortless_flutter_ddd/zooper_effortless_flutter_ddd.dart';

abstract class Entity<TId extends Id> {
  final TId _id;

  TId get id => _id;

  const Entity({required TId id}) : _id = id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Entity && runtimeType == other.runtimeType && _id == other._id;

  @override
  int get hashCode => _id.hashCode;
}
