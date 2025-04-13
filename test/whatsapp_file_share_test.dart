import 'package:flutter_test/flutter_test.dart';
import 'package:whatsapp_file_share/whatsapp_file_share.dart';
import 'package:whatsapp_file_share/whatsapp_file_share_platform_interface.dart';
import 'package:whatsapp_file_share/whatsapp_file_share_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWhatsappFileSharePlatform
    with MockPlatformInterfaceMixin
    implements WhatsappFileSharePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WhatsappFileSharePlatform initialPlatform = WhatsappFileSharePlatform.instance;

  test('$MethodChannelWhatsappFileShare is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWhatsappFileShare>());
  });

  test('getPlatformVersion', () async {
    WhatsappFileShare whatsappFileSharePlugin = WhatsappFileShare();
    MockWhatsappFileSharePlatform fakePlatform = MockWhatsappFileSharePlatform();
    WhatsappFileSharePlatform.instance = fakePlatform;

    expect(await whatsappFileSharePlugin.getPlatformVersion(), '42');
  });
}
