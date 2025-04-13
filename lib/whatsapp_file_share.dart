import 'package:whatsapp_file_share/whatsapp_file_share_method_channel.dart';

import 'whatsapp_file_share_platform_interface.dart';

class WhatsappFileShare {
  Future<String?> getPlatformVersion() {
    return WhatsappFileSharePlatform.instance.getPlatformVersion();
  }

  /// Checks whether whatsapp is installed in device or not
  ///
  /// [Package] is optional enum parameter which is defualt to [Package.whatsapp]
  /// for business whatsapp set it to [Package.businessWhatsapp], it cannot be null
  ///
  /// return true if installed otherwise false.
  static Future<bool?> isInstalled({Package package = Package.whatsapp}) async {
    return WhatsappFileSharePlatform.instance.isInstalled(package: package);
  }

  /// Shares a message or/and link url with whatsapp.
  /// - Text: Is the [text] of the message.
  /// - LinkUrl: Is the [linkUrl] to include with the message.
  /// - Phone: is the [phone] contact number to share with.

  static Future<bool?> share({
    required String phone,
    String? text,
    String? linkUrl,
    Package package = Package.whatsapp,
  }) async {
    return WhatsappFileSharePlatform.instance.share(
      phone: phone,
      text: text,
      linkUrl: linkUrl,
      package: package,
    );
  }

  /// Shares a local file with whatsapp.
  /// - Text: Is the [text] of the message.
  /// - FilePath: Is the List of paths which can be prefilled.
  /// - Phone: is the [phone] contact number to share with.
  static Future<bool?> shareFile({
    required List<String> filePath,
    required String phone,
    @Deprecated("No support for text along with files, this field is ignored")
    String? text,
    Package package = Package.whatsapp,
  }) async {
    return WhatsappFileSharePlatform.instance.shareFile(
      filePath: filePath,
      phone: phone,
      text: text,
      package: package,
    );
  }
}
