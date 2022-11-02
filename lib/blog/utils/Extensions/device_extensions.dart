import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Constants.dart';

enum DeviceSize { mobile, tablet, desktop }

extension LayoutUtils on BoxConstraints {
  /// returns DeviceSize
  DeviceSize get device {
    if (this.maxWidth >= desktopBreakpointGlobal) {
      return DeviceSize.desktop;
    }
    if (this.maxWidth >= tabletBreakpointGlobal) {
      return DeviceSize.tablet;
    }
    return DeviceSize.mobile;
  }
}

bool get isWeb => kIsWeb;

bool get isMobile => !isWeb && (Platform.isIOS || Platform.isAndroid);

bool get isAndroid => !isWeb && Platform.isAndroid;

bool get isIos => !isWeb && Platform.isIOS;





