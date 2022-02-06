/// Неймспейс для всех ключей в SharedPreference
const String kStorageNamespace = 'dev.plugfox.dartjobs.flutter';

/// Ключи по которым сохраняем текущую версию приложения
const String kVersionMajorKey = '$kStorageNamespace.version_major';
const String kVersionMinorKey = '$kStorageNamespace.version_minor';
const String kVersionPatchKey = '$kStorageNamespace.version_patch';

/// Ключ по которому хранится информация, запрашивалось ли уже разрешение на пуши
const String kCloudMessagingPushRequested = '$kStorageNamespace.fcm_push_requested';
