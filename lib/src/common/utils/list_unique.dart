extension Unique<E, Id> on List<E> {
  List<E> unique(Id Function(E element) id) {
    final ids = <Id>{};
    return this..retainWhere((x) => ids.add(id(x)));
  }
}
