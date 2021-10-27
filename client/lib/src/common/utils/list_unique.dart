extension Unique<E, Id> on List<E> {
  List<E> unique(final Id Function(E element) id) {
    final ids = <Id>{};
    return this..retainWhere((final x) => ids.add(id(x)));
  }
}
