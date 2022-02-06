import 'package:meta/meta.dart';

@immutable
class NotificationStatus {
  const NotificationStatus({
    required final this.isAuthorized,
    required final this.isSupported,
  });

  @literal
  const NotificationStatus.notSupported()
      : isAuthorized = false,
        isSupported = false;

  @literal
  const NotificationStatus.authorized()
      : isAuthorized = true,
        isSupported = true;

  @literal
  const NotificationStatus.notAuthorized()
      : isAuthorized = false,
        isSupported = true;

  final bool isSupported;

  bool get isNotSupported => !isSupported;

  final bool isAuthorized;

  bool get notAuthorized => !isAuthorized;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationStatus && other.isAuthorized == isAuthorized && other.isSupported == isSupported);

  @override
  int get hashCode => isAuthorized ? 2 : (isSupported ? 1 : 0);
}
