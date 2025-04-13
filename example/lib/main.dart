import 'package:flutter/material.dart';
import 'package:whatsapp_file_share/whatsapp_file_share.dart';
import 'package:whatsapp_file_share/whatsapp_file_share_method_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('WhatsApp Share Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  try {
                    bool? isInstalled = await WhatsappFileShare.isInstalled(
                      package: Package.whatsapp,
                    );
                    print('Is WhatsApp installed? $isInstalled');
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text('Check WhatsApp Installation'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await WhatsappFileShare.share(
                      text: 'Hello',
                      phone: '91123456789',
                      package: Package.whatsapp,
                      linkUrl: 'https://example.com',
                    );
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text('Share Text via WhatsApp'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await WhatsappFileShare.shareFile(
                      filePath: ['/path/to/file1.txt', '/path/to/file2.jpg'],
                      phone: '911234567890',
                      package: Package.whatsapp,
                      text: 'Check out these files!',
                    );
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text('Share Files via WhatsApp'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
