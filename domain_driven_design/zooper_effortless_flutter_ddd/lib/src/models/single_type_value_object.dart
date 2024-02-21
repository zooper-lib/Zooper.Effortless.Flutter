import 'package:zooper_effortless_flutter_ddd/zooper_effortless_flutter_ddd.dart';

abstract class SingleTypeValueObject<T> extends ValueObject {
  final T _value;

  T get value => _value;

  const SingleTypeValueObject(this._value);

  @override
  List<Object?> get props => [_value];
}
