extension NullOrX<T> on T? {
  R? nullOr<R>(R? Function(T) fn) {
    final t = this;
    return t == null ? null : fn(t);
  }
}
