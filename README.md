# [Whatsapp_file Share Plugin](https://pub.dev/packages/whatsapp_file_share)

[![pub package](https://img.shields.io/pub/v/whatsapp_share.svg)](https://pub.dartlang.org/packages/whatsapp_file_share)

A Flutter plugin for Android providing a simple way to share a message, link or local files to specific WhatsApp contact.

## Features:

- Share messages or link urls to specific contact.
- Share local files to specific contact.

## Installation

First, add this to your package's pubspec.yaml file:

```
dependencies:
  whatsapp_file_share: ^1.0.0
```

Now in your Dart code, you can use:

```
import 'package:whatsapp_file_share/whatsapp_file_share.dart';
```

## Installation (Platform Specific)

Currently Supports only Android Platform

### Android

If you pretends to use the file share, you need to configure the file provider, this will give access to the files turning possible to share with other applications.

Add to `AndroidManifest.xml`:

```
<application>
...
<provider
    android:name="androidx.core.content.FileProvider"
    android:authorities="${applicationId}.provider"
    android:exported="false"
    android:grantUriPermissions="true">
    <meta-data
        android:name="android.support.FILE_PROVIDER_PATHS"
        android:resource="@xml/provider_paths"/>
</provider>
</application>
```

Obs: You can change the android:name if you have an extension of file provider.

Add `res/xml/file_paths.xml`:

```
<?xml version="1.0" encoding="utf-8"?>
<paths xmlns:android="http://schemas.android.com/apk/res/android">
    <external-path name="external_files" path="."/>
</paths>
```

If you want to learn more about file provider you can access:

- https://developer.android.com/reference/android/support/v4/content/FileProvider

## How to use?

Here is an snippets app displaying the two whatsapp share methods .

### Whatsapp installed in this device ?

```Dart
 Future<void> isInstalled() async {
    final val = await WhatsappFileShare.isInstalled(
      package: Package.businessWhatsapp
    );
    print('Whatsapp Business is installed: $val');
  }
```

<small>If whatsapp is not installed, please do not call `WhatsappFileShare.share()` and `WhatsappFileShare.shareFile()`
</small>

### Share text, links

```Dart

 Future<void> share() async {
    await WhatsappFileShare.share(
      text: 'Whatsapp share text',
      linkUrl: 'https://flutter.dev/',
      phone: '911234567890',
    );
  }

```

### Share images, files

`_image1.path` contains path of the file which is shared to the whatsapp.

```Dart

 Future<void> shareFile() async {
    await WhatsappFileShare.shareFile(
      phone: '911234567890',
      filePath: [_image1.path, _image2.path],
    );
  }

//Below code is for specific to package type

  await WhatsappFileShare.shareFile(
    package: type == WhatsappPackage.businessWhatsapp
        ? Package.businessWhatsapp
        : Package.whatsapp,
    text: text,
    phone: '91$number',
    filePath: [path],
  );
```
