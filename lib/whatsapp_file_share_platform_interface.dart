import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'whatsapp_file_share_method_channel.dart';

abstract class WhatsappFileSharePlatform extends PlatformInterface {
  /// Constructs a WhatsappFileSharePlatform.
  WhatsappFileSharePlatform() : super(token: _token);

  static final Object _token = Object();

  static WhatsappFileSharePlatform _instance = MethodChannelWhatsappFileShare();

  /// The default instance of [WhatsappFileSharePlatform] to use.
  ///
  /// Defaults to [MethodChannelWhatsappFileShare].
  static WhatsappFileSharePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WhatsappFileSharePlatform] when
  /// they register themselves.
  static set instance(WhatsappFileSharePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> isInstalled({Package package = Package.whatsapp}) {
    throw UnimplementedError('isInstalled() has not been implemented.');
  }

  Future<bool?> share({
    required String phone,
    String? text,
    String? linkUrl,
    Package package = Package.whatsapp,
  }) {
    throw UnimplementedError('share() has not been implemented.');
  }

  Future<bool?> shareFile({
    required List<String> filePath,
    required String phone,
    @Deprecated("No support for text along with files, this field is ignored")
    String? text,
    Package package = Package.whatsapp,
  }) {
    throw UnimplementedError('shareFile() has not been implemented.');
  }
}
