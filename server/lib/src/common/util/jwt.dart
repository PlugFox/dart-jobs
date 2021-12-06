import 'dart:collection';
import 'dart:convert';

import 'package:meta/meta.dart';
// import 'package:pointycastle/pointycastle.dart';

/// Токен JWT состоит из трех частей: заголовка (header), полезной нагрузки (payload) и подписи или данных шифрования.
/// Первые два элемента — это JSON объекты определенной структуры.
/// Третий элемент вычисляется на основании первых и зависит от выбранного алгоритма
/// (в случае использования неподписанного JWT может быть опущен).
/// Токены могут быть перекодированы в компактное представление (JWS/JWE Compact Serialization):
/// к заголовку и полезной нагрузке применяется алгоритм кодирования Base64-URL,
/// после чего добавляется подпись и все три элемента разделяются точками («.»).
@immutable
abstract class JWT {
  /// Decode a string JWT token into a `Map<String, Object>`
  /// containing the decoded JSON payload.
  ///
  /// Note: header and signature are not returned by this method.
  ///
  /// Throws [FormatException] if parameter is not a valid JWT token.
  factory JWT.decode(String token) = _JWTImpl.decode;

  /// Can return null, static method, not factory
  // ignore: prefer_constructors_over_static_methods
  static JWT? tryDecode(String token) {
    try {
      return JWT.decode(token);
    } on Object {
      return null;
    }
  }

  /*
  factory JWT.create({
    /// Header, algorithm & token type
    required final Map<String, Object?> header,

    /// Payload / Data
    required final Map<String, Object?> payload,

    /// Secret for creating a signed token
    required final String? secret,
  }) =>
      _JWTImpl.create(
        header: header,
        payload: payload,
        secret: secret,
      );
  */

  /// Токен подписан, [signature] не пустая
  bool get isSigned;

  /// Header, algorithm & token type
  JWTHeader get header;

  /// Payload / Data
  JWTPayload get payload;

  /// Verify signature
  String get signature;

  /// Validates and returns a list of validation errors.
  /// Empty set indicates there were no validation errors.
  /// Проверяет заполнение содержимого
  Set<String> validatePayload({
    /// Проверить алгоритм на соответсвие
    final String? algorithm,

    /// Текущее время для проверки актуальности токена, по умолчанию - DateTime.now()
    final DateTime? dateTime,

    /// Допуск расхождения с текущим временем (с точностью до секунд)
    final Duration? tolerance,

    /// Проверить истекание
    final bool expiresAt = true,

    /// Проверить выпуск
    final bool issuedAt = false,

    /// Проверить время с которого он начинает действовать
    final bool notBefore = false,

    /// Проверить идентификатор проекта
    final String? audience,

    /// Проверить выпустившего токен
    final String? issuer,

    /// Проверить принадлежность пользователю
    final String? subject,
  });

  // /// Проверка подписи с помощью секрета или публичного ключа
  // bool validateSignature(String key);

  /// Получить исходный токен в виде строки
  @override
  String toString();
}

/// HashMap<String, Object?>
@immutable
abstract class _ImmutableJSON extends MapBase<String, Object?> {
  Map<String, Object?> get _source;

  @override
  Object? operator [](Object? key) => _source[key];

  @override
  Iterable<String> get keys => _source.keys;

  @override
  void operator []=(String key, Object? value) => throw UnsupportedError('Cannot modify unmodifiable map');

  @override
  void clear() => throw UnsupportedError('Cannot modify unmodifiable map');

  @override
  Object? remove(Object? key) => throw UnsupportedError('Cannot modify unmodifiable map');
}

/// В заголовке указывается необходимая информация для описания самого токена.
@immutable
abstract class JWTHeader extends _ImmutableJSON {
  /// List of standard (reserved) claims.
  static const Set<String> reservedClaims = <String>{'alg', 'kid', 'typ', 'cty'};

  /// Algorithm (alg)
  /// Алгоритм, используемый для подписи/шифрования (в случае неподписанного JWT используется значение «none»).
  String get algorithm;

  /// Key ID (kid)
  String? get keyID;

  /// Type of token (typ)
  /// Тип токена (type). Используется в случае, когда токены смешиваются с другими объектами,
  /// имеющими JOSE заголовки. Должно иметь значение «JWT».
  String? get tokenType;

  /// Content type (cty)
  /// Тип содержимого (content type).
  /// Если в токене помимо зарегистрированных служебных ключей есть пользовательские,
  /// то данный ключ не должен присутствовать. В противном случае должно иметь значение «JWT»
  String? get contentType;
}

/// В данной секции указывается пользовательская информация (например, имя пользователя и уровень его доступа),
/// а также могут быть использованы некоторые служебные ключи. Все они являются необязательными
abstract class JWTPayload extends _ImmutableJSON {
  /// List of standard (reserved) claims / payload.
  static const Set<String> reservedClaims = <String>{'iss', 'aud', 'iat', 'exp', 'nbf', 'sub', 'jti'};

  /// The issuer of this token (iss).
  /// Чувствительная к регистру строка или URI,
  /// которая является уникальным идентификатором стороны, генерирующей токен (issuer).
  String? get issuer;

  /// The audience of this token (aud).
  /// Массив чувствительных к регистру строк или URI, являющийся списком получателей данного токена.
  /// Когда принимающая сторона получает JWT с данным ключом,
  /// она должна проверить наличие себя в получателях — иначе проигнорировать токен (audience).
  Object? get audience;

  /// The time this token was issued (iat).
  /// Время в формате Unix Time, определяющее момент, когда токен был создан.
  /// [issuedAt] и [notBefore] могут не совпадать, например, если токен был создан раньше,
  /// чем время, когда он должен стать валидным
  int? get issuedAt;

  /// The expiration time of this token (exp).
  /// Время в формате Unix Time, определяющее момент, когда токен станет невалидным (expiration).
  int? get expiresAt;

  /// The time before which this token must not be accepted (nbf).
  /// В противоположность ключу [expiresAt], это время в формате Unix Time, определяющее момент,
  /// когда токен станет валидным (not before).
  int? get notBefore;

  /// Identifies the principal that is the subject of this token (sub).
  /// Чувствительная к регистру строка или URI, которая является уникальным идентификатором стороны,
  /// о которой содержится информация в данном токене (subject).
  /// Значения с этим ключом должны быть уникальны в контексте стороны, генерирующей JWT.
  /// По сути это UID пользователя.
  String? get subject;

  /// Unique identifier of this token (jti).
  /// Строка, определяющая уникальный идентификатор данного токена (JWT ID).
  String? get jwtID;
}

class _JWTImpl with _JWTValidationMixin implements JWT {
  factory _JWTImpl.decode(String token) {
    final splitToken = token.split('.'); // Split the token by '.'
    final length = splitToken.length;
    if (length < 2 || length > 3) {
      throw const FormatException('Invalid token');
    }
    return _JWTImpl._(
      header: _JWTHeaderImpl.decode(splitToken[0]),
      payload: _JWTPayloadImpl.decode(splitToken[1]),
      signature: length < 3 ? '' : splitToken[2],
      token: token,
    );
  }

  /*
  factory _JWTImpl.create({
    required final Map<String, Object?> header,
    required final Map<String, Object?> payload,
    required final String? secret,
  }) {
    final createdHeader = _JWTHeaderImpl.create(header);
    final createdPayload = _JWTPayloadImpl.create(payload);

    final _jsonToBase64Url = json.fuse(utf8.fuse(base64Url));

    final buffer = StringBuffer();
    final headerBase64 = _base64Unpadded(_jsonToBase64Url.encode(createdHeader));
    buffer.write(headerBase64);
    final payloadBase64 = _base64Unpadded(_jsonToBase64Url.encode(createdPayload));
    buffer
      ..write('.')
      ..write(payloadBase64);

    if (secret != null) {
      final algorithm = JWTAlgorithm.fromName(createdHeader.algorithm);
      final body = Uint8List.fromList(utf8.encode(buffer.toString()));
      final signature = _base64Unpadded(base64Url.encode(algorithm.sign(secret, body)));
      buffer
        ..write('.')
        ..write(signature);
    }
    final jwt = _JWTImpl.decode(buffer.toString());
    buffer.clear();
    return jwt;
  }
  */

  _JWTImpl._({
    required final this.header,
    required final this.payload,
    required final this.signature,
    required final String token,
  }) : _token = token;

  /// Исходный токен
  final String _token;

  @override
  bool get isSigned => signature.isNotEmpty;

  @override
  final JWTHeader header;

  @override
  final JWTPayload payload;

  @override
  final String signature;

  @override
  String toString() => _token;

  @override
  int get hashCode => _token.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || (other is _JWTImpl && _token == other._token);
}

class _JWTHeaderImpl extends JWTHeader {
  factory _JWTHeaderImpl.decode(final String header) {
    try {
      // Base64 should be multiple of 4. Normalize the payload before decode it
      final normalizedPayload = base64.normalize(header);
      // Decode payload, the result is a String
      final payloadString = utf8.decode(base64.decode(normalizedPayload));
      // Parse the String to a Map<String, Object?>
      final data = jsonDecode(payloadString) as Map<String, Object?>;
      return _JWTHeaderImpl._(data);
    } on Object {
      throw const FormatException('Invalid header');
    }
  }

  //factory _JWTHeaderImpl.create(Map<String, Object?> source) = _JWTHeaderImpl._;

  _JWTHeaderImpl._(Map<String, Object?> source)
      : _source = source,
        algorithm = source['alg']?.toString() ?? '',
        contentType = source['cty']?.toString(),
        keyID = source['kid']?.toString(),
        tokenType = source['typ']?.toString();

  @override
  final Map<String, Object?> _source;

  @override
  final String algorithm;

  @override
  final String? contentType;

  @override
  final String? keyID;

  @override
  final String? tokenType;
}

class _JWTPayloadImpl extends JWTPayload {
  factory _JWTPayloadImpl.decode(final String payload) {
    try {
      // Base64 should be multiple of 4. Normalize the payload before decode it
      final normalizedPayload = base64.normalize(payload);
      // Decode payload, the result is a String
      final payloadString = utf8.decode(base64.decode(normalizedPayload));
      // Parse the String to a Map<String, Object?>
      final data = jsonDecode(payloadString) as Map<String, Object?>;
      return _JWTPayloadImpl._(data);
    } on Object {
      throw const FormatException('Invalid payload');
    }
  }

  // factory _JWTPayloadImpl.create(Map<String, Object?> source) = _JWTPayloadImpl._;

  _JWTPayloadImpl._(Map<String, Object?> source)
      : _source = source,
        audience = source['aud'],
        expiresAt = _getInt(source['exp']),
        issuedAt = _getInt(source['iat']),
        issuer = source['iss']?.toString(),
        jwtID = source['jti']?.toString(),
        notBefore = _getInt(source['nbf']),
        subject = source['sub']?.toString();

  @override
  final Map<String, Object?> _source;

  @override
  final Object? audience;

  @override
  final int? expiresAt;

  @override
  final int? issuedAt;

  @override
  final String? issuer;

  @override
  final String? jwtID;

  @override
  final int? notBefore;

  @override
  final String? subject;

  static int? _getInt(Object? obj) {
    if (obj is int) {
      return obj;
    } else if (obj is String) {
      return int.tryParse(obj);
    } else {
      return null;
    }
  }
}

mixin _JWTValidationMixin implements JWT {
  @override
  Set<String> validatePayload({
    final String? algorithm,
    final DateTime? dateTime,
    final Duration? tolerance,
    final bool expiresAt = true,
    final bool issuedAt = true,
    final bool notBefore = false,
    final String? audience,
    final String? issuer,
    final String? subject,
  }) {
    final errors = <String>{};

    final currentTimestamp = (dateTime ?? DateTime.now()).millisecondsSinceEpoch ~/ 1000;

    final toleranceSec = tolerance?.inSeconds ?? 0;

    if (header.algorithm.isEmpty) {
      errors.add('Algorithm must be a non-empty string');
    }

    if (algorithm != null && algorithm != header.algorithm) {
      errors.add('Algorithm is not the same');
    }

    if (expiresAt) {
      final data = payload.expiresAt;
      if (data == null || data - currentTimestamp + toleranceSec < 0) {
        errors.add('The token has expired');
      }
    }

    if (issuedAt) {
      final data = payload.issuedAt;
      if (data == null || currentTimestamp - data + toleranceSec < 0) {
        errors.add('The token issuedAt time is in future');
      }
    }

    if (notBefore) {
      final data = payload.notBefore;
      if (data == null || currentTimestamp - data + toleranceSec < 0) {
        errors.add('The token can not be accepted due to notBefore policy');
      }
    }

    if (audience != null) {
      if (audience != payload.audience) {
        errors.add('Audience must be your project ID');
      }
    }

    if (issuer != null) {
      if (issuer != payload.issuer) {
        errors.add('Issuer is not the same');
      }
    }

    if (subject != null) {
      if (subject != payload.subject) {
        errors.add('Subject must be a non-empty string and must be the uid of the user or device');
      }
    }

    return errors;
  }

  /*
  @override
  bool validateSignature(String key) {
    if (signature.isEmpty) {
      return false;
    }
    try {
      final algorithm = JWTAlgorithm.fromName(header.algorithm);
      final token = toString().split('.').toList(growable: false);
      if (token.length != 3) return false;
      final body = Uint8List.fromList(utf8.encode(token.take(2).join('.')));
      final signature = Uint8List.fromList(utf8.encode(token.last));
      return algorithm.verify(key, body, signature);
    } on Object catch (err) {
      return false;
    }
  }
  */
}

/*
/// Алгоритм взаимодействия с подписью JWT
abstract class JWTAlgorithm {
  /// HMAC using SHA-256 hash algorithm
  static const JWTAlgorithm hs256 = _HMAC256Algorithm();

  /// RSASSA-PKCS1-v1_5 using SHA-256 hash algorithm
  static const JWTAlgorithm rs256 = _RSA256Algorithm();

  /// Return the `JWTAlgorithm` from his string name
  static JWTAlgorithm fromName(String name) {
    switch (name) {
      case 'HS256':
        return JWTAlgorithm.hs256;
      case 'RS256':
        return JWTAlgorithm.rs256;
      default:
        throw const FormatException('Unknown algorithm');
    }
  }

  const JWTAlgorithm();

  /// `JWTAlgorithm` name
  String get name;

  /// Create a signature of the `body` with `key`
  ///
  /// return the signature as bytes
  Uint8List sign(String key, Uint8List body);

  /// Verify the `signature` of `body` with `key`
  ///
  /// return `true` if the signature is correct `false` otherwise
  bool verify(String key, Uint8List body, Uint8List signature);
}

class _HMAC256Algorithm extends JWTAlgorithm {
  const _HMAC256Algorithm();

  @override
  String get name => 'HS256';

  @override
  Uint8List sign(String key, Uint8List body) {
    final hmac = Hmac(sha256, utf8.encode(key));
    return Uint8List.fromList(hmac.convert(body).bytes);
  }

  @override
  bool verify(String key, Uint8List body, Uint8List signature) {
    try {
      // Приведем подпись к тому же Base64 виду, что и исходная
      final actual = Uint8List.fromList(utf8.encode(_base64Unpadded(base64Url.encode(sign(key, body)))));
      if (actual.length != signature.length) {
        return false;
      }
      for (var i = 0; i < actual.length; i++) {
        if (actual[i] != signature[i]) return false;
      }
      return true;
    } on Object {
      return false;
    }
  }
}

class _RSA256Algorithm extends JWTAlgorithm {
  const _RSA256Algorithm();

  @override
  String get name => 'RS256';

  @override
  Uint8List sign(String pem, Uint8List body) {
    final key = parseRSAPrivateKeyPEM(pem);
    if (key == null) throw const FormatException('RSAPrivateKey is invalid');

    final signer = Signer('SHA-256/RSA');
    final params = PrivateKeyParameter<RSAPrivateKey>(key);

    signer.init(true, params);

    final signature = signer.generateSignature(
      Uint8List.fromList(body),
    ) as RSASignature;

    return signature.bytes;
  }

  @override
  bool verify(String pem, Uint8List body, Uint8List signature) {
    final key = parseRSAPublicKeyPEM(pem);
    if (key == null) throw const FormatException('RSAPublicKey is invalid');

    try {
      final signer = Signer('SHA-256/RSA');
      final params = PublicKeyParameter<RSAPublicKey>(key);

      signer.init(false, params);

      final msg = Uint8List.fromList(body);
      final sign = RSASignature(Uint8List.fromList(signature));

      return signer.verifySignature(msg, sign);
    } on Object {
      return false;
    }
  }

  /* PRIVATE KEYS */

  /// RSA Private Key -> PKCS#1 format
  static const String _pkcs1RSAPrivateHeader = '-----BEGIN RSA PRIVATE KEY-----';
  static const String _pkcs1RSAPrivateFooter = '-----END RSA PRIVATE KEY-----';

  /// RSA Private Key -> PKCS#8 format
  static const String _pkcs8RSAPrivateHeader = '-----BEGIN PRIVATE KEY-----';
  static const String _pkcs8RSAPrivateFooter = '-----END PRIVATE KEY-----';

  /// Parse RSA private key from pem string
  static RSAPrivateKey? parseRSAPrivateKeyPEM(String pem) {
    if (pem.contains(_pkcs1RSAPrivateHeader) && pem.contains(_pkcs1RSAPrivateFooter)) {
      final data = pem
          .substring(
            pem.indexOf(_pkcs1RSAPrivateHeader) + _pkcs1RSAPrivateHeader.length,
            pem.indexOf(_pkcs1RSAPrivateFooter),
          )
          .replaceAll(RegExp(r'[\n\r ]'), '');

      return _pkcs1RSAPrivateKey(base64.decode(data));
    } else if (pem.contains(_pkcs8RSAPrivateHeader) && pem.contains(_pkcs8RSAPrivateFooter)) {
      final data = pem
          .substring(
            pem.indexOf(_pkcs8RSAPrivateHeader) + _pkcs8RSAPrivateHeader.length,
            pem.indexOf(_pkcs8RSAPrivateFooter),
          )
          .replaceAll(RegExp(r'[\n\r ]'), '');

      return _pkcs8RSAPrivateKey(base64.decode(data));
    } else {
      return null;
    }
  }

  /// RSA Private Key -> PKCS#8 parser
  static RSAPrivateKey? _pkcs8RSAPrivateKey(Uint8List bytes) {
    final parser = ASN1Parser(bytes);
    final seq = parser.nextObject() as ASN1Sequence;

    final keySeq = seq.elements?[2] as ASN1OctetString?;
    if (keySeq == null) return null;
    final keyParser = ASN1Parser(keySeq.octets);

    final valuesSeq = keyParser.nextObject() as ASN1Sequence;
    final values = valuesSeq.elements?.cast<ASN1Integer>();

    if (values == null) return null;

    final modulus = values[1].integer;
    final privateExponent = values[3].integer;
    final prime1 = values[4].integer;
    final prime2 = values[5].integer;

    if (modulus == null || privateExponent == null || prime1 == null || prime2 == null) return null;

    return RSAPrivateKey(
      modulus,
      privateExponent,
      prime1,
      prime2,
    );
  }

  /// RSA Private Key -> PKCS#1 parser
  static RSAPrivateKey? _pkcs1RSAPrivateKey(Uint8List bytes) {
    final parser = ASN1Parser(bytes);
    final seq = parser.nextObject() as ASN1Sequence;
    final values = seq.elements?.cast<ASN1Integer>();

    if (values == null) return null;

    final modulus = values[1].integer;
    final privateExponent = values[3].integer;
    final prime1 = values[4].integer;
    final prime2 = values[5].integer;

    if (modulus == null || privateExponent == null || prime1 == null || prime2 == null) return null;

    return RSAPrivateKey(
      modulus,
      privateExponent,
      prime1,
      prime2,
    );
  }

  /* PUBLIC KEYS */

  /// RSA Public Key -> PKCS#1 format
  static const String _pkcs1RSAPublicHeader = '-----BEGIN RSA PUBLIC KEY-----';
  static const String _pkcs1RSAPublicFooter = '-----END RSA PUBLIC KEY-----';

  /// RSA Public Key -> PKCS#8 format
  static const String _pkcs8RSAPublicHeader = '-----BEGIN PUBLIC KEY-----';
  static const String _pkcs8RSAPublicFooter = '-----END PUBLIC KEY-----';

  /// Parse RSA public key from pem string
  static RSAPublicKey? parseRSAPublicKeyPEM(String pem) {
    if (pem.contains(_pkcs1RSAPublicHeader) && pem.contains(_pkcs1RSAPublicFooter)) {
      final data = pem
          .substring(
            pem.indexOf(_pkcs1RSAPublicHeader) + _pkcs1RSAPublicHeader.length,
            pem.indexOf(_pkcs1RSAPublicFooter),
          )
          .replaceAll(RegExp(r'[\n\r ]'), '');

      return _pkcs1RSAPublicKey(base64.decode(data));
    } else if (pem.contains(_pkcs8RSAPublicHeader) && pem.contains(_pkcs8RSAPublicFooter)) {
      final data = pem
          .substring(
            pem.indexOf(_pkcs8RSAPublicHeader) + _pkcs8RSAPublicHeader.length,
            pem.indexOf(_pkcs8RSAPublicFooter),
          )
          .replaceAll(RegExp(r'[\n\r ]'), '');

      return _pkcs8RSAPublicKey(base64.decode(data));
    } else {
      return null;
    }
  }

  /// RSA Public Key -> PKCS#1 parser
  static RSAPublicKey? _pkcs1RSAPublicKey(Uint8List bytes) {
    final parser = ASN1Parser(bytes);
    final seq = parser.nextObject() as ASN1Sequence;
    final values = seq.elements?.cast<ASN1Integer>();

    if (values == null) return null;

    final modulus = values[0].integer;
    final publicExponent = values[1].integer;

    if (modulus == null || publicExponent == null) return null;

    return RSAPublicKey(
      modulus,
      publicExponent,
    );
  }

  /// RSA Public Key -> PKCS#8 parser
  static RSAPublicKey? _pkcs8RSAPublicKey(Uint8List bytes) {
    final parser = ASN1Parser(bytes);
    final seq = parser.nextObject() as ASN1Sequence;
    final keySeq = seq.elements?[1] as ASN1BitString?;

    if (keySeq == null || keySeq.stringValues == null) return null;
    final keyParser = ASN1Parser(Uint8List.fromList(keySeq.stringValues!));

    final valuesSeq = keyParser.nextObject() as ASN1Sequence;
    final values = valuesSeq.elements?.cast<ASN1Integer>();

    if (values == null) return null;

    final modulus = values[0].integer;
    final publicExponent = values[1].integer;

    if (modulus == null || publicExponent == null) return null;

    return RSAPublicKey(modulus, publicExponent);
  }
}

String _base64Unpadded(String value) {
  if (value.endsWith('==')) return value.substring(0, value.length - 2);
  if (value.endsWith('=')) return value.substring(0, value.length - 1);
  return value;
}
*/
