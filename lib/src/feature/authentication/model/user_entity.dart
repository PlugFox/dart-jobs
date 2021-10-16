import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:meta/meta.dart';

@immutable
abstract class UserEntity {
  bool get isAuthenticated;
  bool get isNotAuthenticated;
  AuthenticatedUser? get authenticatedOrNull;

  factory UserEntity.fromFirebase(firebase_auth.User? user) => user == null || user.isAnonymous || user.uid.isEmpty
      ? const UserEntity.notAuthenticated()
      : UserEntity.authenticated(
          uid: user.uid,
          displayName: user.displayName,
          photoURL: user.photoURL,
          email: user.email,
          phoneNumber: user.phoneNumber,
        );

  @literal
  const factory UserEntity.notAuthenticated() = NotAuthenticatedUser;

  factory UserEntity.authenticated({
    required final String uid,
    required final String? displayName,
    required final String? photoURL,
    required final String? email,
    required final String? phoneNumber,
  }) = AuthenticatedUser;

  T when<T extends Object?>({
    required T Function(AuthenticatedUser user) authenticated,
    required T Function() notAuthenticated,
  });
}

class NotAuthenticatedUser implements UserEntity {
  @override
  bool get isAuthenticated => false;

  @override
  bool get isNotAuthenticated => true;

  @override
  AuthenticatedUser? get authenticatedOrNull => null;

  @literal
  const NotAuthenticatedUser();

  @override
  T when<T extends Object?>({
    required T Function(AuthenticatedUser user) authenticated,
    required T Function() notAuthenticated,
  }) =>
      notAuthenticated();

  @override
  String toString() => 'User is not authenticated';

  @override
  bool operator ==(Object other) => other is NotAuthenticatedUser;

  @override
  int get hashCode => 0;
}

class AuthenticatedUser implements UserEntity {
  @override
  bool get isAuthenticated => !isNotAuthenticated;

  @override
  bool get isNotAuthenticated => uid.isEmpty;

  @override
  AuthenticatedUser? get authenticatedOrNull => isNotAuthenticated ? null : this;

  final String uid;
  final String? displayName;
  final String? photoURL;
  final String? email;
  final String? phoneNumber;

  AuthenticatedUser({
    required final this.uid,
    required final this.displayName,
    required final this.photoURL,
    required final this.email,
    required final this.phoneNumber,
  });

  @override
  T when<T extends Object?>({
    required T Function(AuthenticatedUser user) authenticated,
    required T Function() notAuthenticated,
  }) =>
      authenticated(this);

  @override
  String toString() => 'UserEntity('
      'uid: $uid, '
      'displayName: $displayName, '
      'email: $email, '
      'phoneNumber: $phoneNumber, '
      'photoURL: $photoURL)';

  @override
  bool operator ==(Object other) => other is AuthenticatedUser && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}
