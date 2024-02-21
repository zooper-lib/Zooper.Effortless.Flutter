abstract class ValueObject {
  List<Object?> get props;

  const ValueObject();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueObject &&
          runtimeType == other.runtimeType &&
          props.every((prop) => other.props.contains(prop));

  @override
  int get hashCode => props.fold(0, (prev, element) => prev ^ element.hashCode);
}
