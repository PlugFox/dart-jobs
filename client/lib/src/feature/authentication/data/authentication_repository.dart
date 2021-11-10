import 'package:dart_jobs/src/feature/authentication/model/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:l/l.dart';
import 'package:platform_info/platform_info.dart';

abstract class IAuthenticationRepository {
  Stream<UserEntity> get authStateChanges;

  UserEntity get currentUser;

  /// Разлогиниться
  Future<void> logOut();

  /// Залогиниться в гугле
  Future<UserEntity> signInWithGoogle();
}

class AuthenticationRepository implements IAuthenticationRepository {
  final FirebaseAuth _firebaseAuth;

  AuthenticationRepository({required final FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth;

  @override
  UserEntity get currentUser => _mapUserToUserEntity(_firebaseAuth.currentUser);

  @override
  Stream<UserEntity> get authStateChanges => _firebaseAuth.authStateChanges().map<UserEntity>(_mapUserToUserEntity);

  @override
  Future<UserEntity> signInWithGoogle() {
    try {
      //_firebaseAuth.currentUser?.getIdToken();
      l.vvvv('Начат процесс аутентификации в гугле');
      return platform.when<Future<UserEntity>>(
        io: _signInWithGoogleIO,
        orElse: _signInWithGoogleWeb,
      )!;
    } on Object catch (e) {
      l.w('Произошла ошибка аутентификации в гугле: ${e.toString()}');
      rethrow;
    }
  }

  Future<UserEntity> _signInWithGoogleIO() async {
    final googleSignIn = GoogleSignIn(
      scopes: _kGoogleSignInScopes,
      signInOption: SignInOption.standard,
    );

    l.vvvvv('Начало интерактивной аутентификации в гугле');
    // Trigger the authentication flow
    final googleUser = await googleSignIn.signIn();

    if (googleUser is! GoogleSignInAccount) {
      return const UserEntity.notAuthenticated();
    }

    l.vvvvv('Получение информации об аккаунте');
    // Obtain the auth details from the request
    final googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    l.vvvvv('Окончание аутентификации в firebase');
    // Once signed in, return the UserCredential
    final userCredential = await _firebaseAuth.signInWithCredential(credential);

    return UserEntity.fromFirebase(userCredential.user);
  }

  Future<UserEntity> _signInWithGoogleWeb() async {
    // Create a new provider
    final googleProvider = GoogleAuthProvider()..scopes.addAll(_kGoogleSignInScopes);

    l.vvvvv('Интерактивная аутентификация в firebase');
    // Once signed in, return the UserCredential
    final userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
    // return _firebaseAuth.signInWithRedirect(googleProvider);

    return UserEntity.fromFirebase(userCredential.user);
  }

  @override
  Future<void> logOut() => _firebaseAuth.signOut();

  UserEntity _mapUserToUserEntity(final User? user) => UserEntity.fromFirebase(user);
}

const List<String> _kGoogleSignInScopes = <String>[
  'email',
  'profile',
  // 'https://www.googleapis.com/auth/contacts.readonly',
];
