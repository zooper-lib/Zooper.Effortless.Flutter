import 'package:zooper_effortless_flutter_ddd/zooper_effortless_flutter_ddd.dart';

abstract class Id<T> extends SingleTypeValueObject<T> {
  const Id(super.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Id && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => '$runtimeType($value)';
}
