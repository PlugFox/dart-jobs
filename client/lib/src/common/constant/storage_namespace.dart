/// Неймспейс для всех ключей в SharedPreference
const String storageNamespace = 'dev.plugfox.dartjobs.flutter';

/// Ключи по которым сохраняем текущую версию приложения
const String versionMajorKey = '$storageNamespace.version_major';
const String versionMinorKey = '$storageNamespace.version_minor';
const String versionPatchKey = '$storageNamespace.version_patch';
const String versionBuildKey = '$storageNamespace.version_build';
