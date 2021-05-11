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

  Iterable<MapEntry<int, E>> enumerate() sync* {
    final iterator = this.iterator;
    int i = 0;
    while (iterator.moveNext()) {
      yield MapEntry(i++, iterator.current);
    }
  }

  Iterable<E> addBetween(E separator) sync* {
    final iterator = this.iterator;
    if (!iterator.moveNext()) {
      return;
    }
    yield iterator.current;
    while (iterator.moveNext()) {
      yield separator;
      yield iterator.current;
    }
  }

  Iterable<E> addAround(E separator) sync* {
    final iterator = this.iterator;
    yield separator;
    while (iterator.moveNext()) {
      yield iterator.current;
      yield separator;
    }
  }
}
