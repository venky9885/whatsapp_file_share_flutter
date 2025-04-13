import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'whatsapp_file_share_platform_interface.dart';

enum Package { whatsapp, businessWhatsapp }

/// An implementation of [WhatsappFileSharePlatform] that uses method channels.
class MethodChannelWhatsappFileShare extends WhatsappFileSharePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('whatsapp_file_share');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<bool?> isInstalled({Package package = Package.whatsapp}) async {
    String _package;
    _package = package.index == 0 ? "com.whatsapp" : "com.whatsapp.w4b";
    final bool? success = await methodChannel.invokeMethod<bool>(
      'isInstalled',
      <String, dynamic>{"package": _package},
    );
    return success;
  }

  /// Shares a message or/and link url with whatsapp.
  /// - Text: Is the [text] of the message.
  /// - LinkUrl: Is the [linkUrl] to include with the message.
  /// - Phone: is the [phone] contact number to share with.

  Future<bool?> share({
    required String phone,
    String? text,
    String? linkUrl,
    Package package = Package.whatsapp,
  }) async {
    assert(phone.isNotEmpty);

    String _package;
    _package = package.index == 0 ? "com.whatsapp" : "com.whatsapp.w4b";

    final bool? success = await methodChannel
        .invokeMethod('share', <String, dynamic>{
          'title': ' ',
          'text': text,
          'linkUrl': linkUrl,
          'chooserTitle': ' ',
          'phone': phone,
          'package': _package,
        });

    return success;
  }

  /// Shares a local file with whatsapp.
  /// - Text: Is the [text] of the message.
  /// - FilePath: Is the List of paths which can be prefilled.
  /// - Phone: is the [phone] contact number to share with.
  Future<bool?> shareFile({
    required List<String> filePath,
    required String phone,
    @Deprecated("No support for text along with files, this field is ignored")
    String? text,
    Package package = Package.whatsapp,
  }) async {
    assert(filePath.isNotEmpty);
    assert(phone.isNotEmpty);

    if (filePath.isEmpty) {
      throw FlutterError('FilePath cannot be Empty');
    } else if (phone.isEmpty) {
      throw FlutterError('Phone cannot be Empty');
    }

    String _package;
    _package = package.index == 0 ? "com.whatsapp" : "com.whatsapp.w4b";

    final bool? success = await methodChannel
        .invokeMethod('shareFile', <String, dynamic>{
          'title': ' ',
          'text': ' ',
          'filePath': filePath,
          'chooserTitle': ' ',
          'phone': phone,
          'package': _package,
        });

    return success;
  }
}
