import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart';

abstract class JWT extends MapBase<String, Object> {
  final Map<String, Object?> _payload;

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

  factory JWT.fromJson(Map<String, Object> payload) = _JWTImpl.fromJson;

  Map<String, Object?> toJson();

  JWT._(Map<String, Object?> payload) : _payload = payload;

  /// HS256 Header
  static const Map<String, Object> header = <String, Object>{'alg': 'HS256'};

  /// List of standard (reserved) claims/payload.
  static const List<String> reservedClaims = <String>['iss', 'aud', 'iat', 'exp', 'nbf', 'sub', 'jti'];

  /// Algorithm used to sign this token.
  String get algorithm;

  /// The issuer of this token (value of standard `iss` claim).
  Object get issuer;

  /// The audience of this token (value of standard `aud` claim).
  Object get audience;

  /// The time this token was issued (value of standard `iat` claim).
  int get issuedAt;

  /// The expiration time of this token (value of standard `exp` claim).
  int get expiresAt;

  /// The time before which this token must not be accepted (value of standard
  /// `nbf` claim).
  int get notBefore;

  /// Identifies the principal that is the subject of this token (value of
  /// standard `sub` claim).
  Object get subject;

  /// Unique identifier of this token (value of standard `jti` claim).
  Object get id;

  /// Validates and returns a list of validation errors.
  /// Empty list indicates there were no validation errors.
  Set<String> validate();

  String toSignedString(String secret);
}

class _JWTImpl extends JWT with _JWTMapMethods, _JWTCommonFieldsMixin, _JWTHS256Mixin, _JWTValidatorMixin {
  factory _JWTImpl.decode(String token) {
    final splitToken = token.split('.'); // Split the token by '.'
    if (splitToken.length != 3) {
      throw const FormatException('Invalid token');
    }
    try {
      final payloadBase64 = splitToken[1]; // Payload is always the index 1
      // Base64 should be multiple of 4. Normalize the payload before decode it
      final normalizedPayload = base64.normalize(payloadBase64);
      // Decode payload, the result is a String
      final payloadString = utf8.decode(base64.decode(normalizedPayload));
      // Parse the String to a Map<String, dynamic>
      final payload = jsonDecode(payloadString) as Map<String, dynamic>;
      return _JWTImpl.fromJson(payload);
    } on Object {
      throw const FormatException('Invalid payload');
    }
  }

  _JWTImpl.fromJson(Map<String, Object?> payload) : super._(payload);

  @override
  Map<String, Object?> toJson() => Map<String, Object?>.of(super._payload);
}

mixin _JWTMapMethods on JWT {
  @override
  Object? operator [](Object? key) => super._payload[key];

  @override
  void operator []=(String key, Object value) => super._payload[key] = value;

  @override
  void clear() => super._payload.clear();

  @override
  Iterable<String> get keys => super._payload.keys;

  @override
  Object? remove(Object? key) => super._payload.remove(key);
}

mixin _JWTCommonFieldsMixin on JWT {
  @override
  Object get issuer => this['iss']!;

  @override
  Object get audience => this['aud']!;

  @override
  int get issuedAt => this['iat'] as int;

  @override
  int get expiresAt => this['exp'] as int;

  @override
  int get notBefore => this['nbf'] as int;

  @override
  Object get subject => this['sub']!;

  @override
  Object get id => this['jti']!;
}

mixin _JWTValidatorMixin on JWT {
  @override
  Set<String> validate() {
    final errors = <String>{};

    final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    if (currentTimestamp >= expiresAt) {
      errors.add('The token has expired.');
    }

    if (currentTimestamp < issuedAt) {
      errors.add('The token issuedAt time is in future.');
    }

    if (currentTimestamp < notBefore) {
      errors.add('The token can not be accepted due to notBefore policy.');
    }
    return errors;
  }
}

mixin _JWTHS256Mixin on JWT {
  @override
  String get algorithm => 'HS256';

  @override
  String toString() => toSignedString('');

  @override
  String toSignedString(String secret) {
    final _jsonToBase64Url = json.fuse(utf8.fuse(base64Url));
    String _base64Unpadded(String value) {
      if (value.endsWith('==')) return value.substring(0, value.length - 2);
      if (value.endsWith('=')) return value.substring(0, value.length - 1);
      return value;
    }

    /// Result buffer
    final buffer = StringBuffer();

    /// ALGORITHM & TOKEN TYPE
    final headerBase64 = _base64Unpadded(_jsonToBase64Url.encode(JWT.header));
    buffer.write(headerBase64);

    /// PAYLOAD:DATA
    final payloadBase64 = _base64Unpadded(_jsonToBase64Url.encode(super._payload));
    buffer
      ..write('.')
      ..write(payloadBase64);

    /// VERIFY SIGNATURE
    final hmac = Hmac(sha256, utf8.encode(secret));
    final body = utf8.encode(buffer.toString());
    final signature = _base64Unpadded(base64Url.encode(hmac.convert(body).bytes));

    /// Build result
    return (buffer
          ..write('.')
          ..write(signature))
        .toString();
  }
}
