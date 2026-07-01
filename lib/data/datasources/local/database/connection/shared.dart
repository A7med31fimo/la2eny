// Conditional import: chooses the native implementation on mobile/desktop,
// and the web implementation when compiled for the browser.
export 'unsupported.dart'
    if (dart.library.ffi) 'native.dart'
    if (dart.library.html) 'web.dart';
