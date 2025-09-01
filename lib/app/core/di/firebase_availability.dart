import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Indicates whether Firebase.initializeApp() succeeded for the current platform.
/// Default is false; main.dart overrides this at runtime.
final firebaseAvailableProvider = Provider<bool>((ref) => false);

