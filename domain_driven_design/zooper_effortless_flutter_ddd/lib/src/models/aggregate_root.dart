import 'package:zooper_effortless_flutter_ddd/zooper_effortless_flutter_ddd.dart';

abstract class AggregateRoot<TId extends Id> extends Entity<TId> {
  const AggregateRoot({required super.id});
}
