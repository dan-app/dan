extension X<T> on T {
  U let<U>(U Function(T it) block) => block(this);

  T also(void Function(T it) block) => this..let(block);
}

extension IterableX<E> on Iterable<E> {
  E minBy(Comparable<Object> Function(E) fieldGetter) {
    return reduce(
      (a, b) => fieldGetter(a).compareTo(fieldGetter(b)) < 0 ? a : b,
    );
  }

  E maxBy(Comparable<Object> Function(E) fieldGetter) {
    return reduce(
      (a, b) => fieldGetter(a).compareTo(fieldGetter(b)) > 0 ? a : b,
    );
  }
}
