class Series<T> {
  final List<T> data;

  final Type dType;

  bool get isNumeric => data.every((it) => it is num);

  Series(this.data) : dType = data.genericType;

  static Series<U> from<U extends Object?>(List<U> data) => Series(data);

  Series<T> head(int n) => Series(data.sublist(0, n));
}

extension Typing<T> on List<T> {
  /// Provide access to the generic type at runtime.
  Type get genericType => T;
}
