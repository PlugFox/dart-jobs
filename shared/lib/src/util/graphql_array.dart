/// Неймспейс позволяющий взаимодействовать с представлением массива в виде строки в GraphQL
abstract class GraphQLArray {
  GraphQLArray._();

  /// Преобразует коллекцию к представлению графкл в виде строки
  /// Исходные данные не должны содержать символов "{,}"
  static String toGraphQL<T extends Object?>(
    Iterable<T> collection, [
    String Function(T e) convert = _defaultGraphQLConverter,
  ]) =>
      '{${collection.map<String>(convert).join(',')}}';

  /// Преобразует коллекцию графкл в виде строки к дарту
  /// Исходные данные не должны содержать символов "{,}"
  static Iterable<T> toDart<T extends Object?>(String collection, T Function(String e) convert) {
    final values = collection.trim();
    return values.substring(1, values.length - 1).split(',').map((e) => e.trim()).map<T>(convert);
  }

  static String _defaultGraphQLConverter(final Object? object) => object == null ? 'null' : object.toString();
}
