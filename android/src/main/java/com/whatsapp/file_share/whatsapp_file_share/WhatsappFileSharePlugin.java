package com.whatsapp.file_share.whatsapp_file_share;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.core.content.FileProvider;

import java.io.File;
import java.util.ArrayList;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class WhatsappFileSharePlugin implements FlutterPlugin, MethodCallHandler {
  private MethodChannel channel;
  private Context applicationContext;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    this.applicationContext = flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "whatsapp_file_share");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    applicationContext = null;
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("shareFile")) {
      shareFile(call, result);
    } else if (call.method.equals("share")) {
      share(call, result);
    } else if (call.method.equals("isInstalled")) {
      isInstalled(call, result);
    } else {
      result.notImplemented();
    }
  }

  private boolean isPackageInstalled(String packageName, PackageManager packageManager) {
    try {
      packageManager.getPackageInfo(packageName, 0);
      return true;
    } catch (PackageManager.NameNotFoundException e) {
      return false;
    }
  }

  private void isInstalled(MethodCall call, Result result) {
    try {
      String packageName = call.argument("package");

      if (packageName == null || packageName.isEmpty()) {
        Log.println(Log.ERROR, "", "FlutterShare Error: Package name null or empty");
        result.error("FlutterShare:Package name cannot be null or empty", null, null);
        return;
      }

      PackageManager pm = applicationContext.getPackageManager();
      boolean isInstalled = isPackageInstalled(packageName, pm);
      result.success(isInstalled);
    } catch (Exception ex) {
      Log.println(Log.ERROR, "", "FlutterShare: Error");
      result.error(ex.getMessage(), null, null);
    }
  }

  private void share(MethodCall call, Result result) {
    try {
      String title = call.argument("title");
      String text = call.argument("text");
      String linkUrl = call.argument("linkUrl");
      String chooserTitle = call.argument("chooserTitle");
      String phone = call.argument("phone");
      String packageName = call.argument("package");

      if (title == null || title.isEmpty()) {
        Log.println(Log.ERROR, "", "FlutterShare Error: Title null or empty");
        result.error("FlutterShare: Title cannot be null or empty", null, null);
        return;
      } else if (phone == null || phone.isEmpty()) {
        Log.println(Log.ERROR, "", "FlutterShare Error: phone null or empty");
        result.error("FlutterShare: phone cannot be null or empty", null, null);
        return;
      } else if (packageName == null || packageName.isEmpty()) {
        Log.println(Log.ERROR, "", "FlutterShare Error: Package name null or empty");
        result.error("FlutterShare:Package name cannot be null or empty", null, null);
        return;
      }

      ArrayList<String> extraTextList = new ArrayList<>();

      if (text != null && !text.isEmpty()) {
        extraTextList.add(text);
      }
      if (linkUrl != null && !linkUrl.isEmpty()) {
        extraTextList.add(linkUrl);
      }

      String extraText = TextUtils.join("\n\n", extraTextList);

      Intent intent = new Intent();
      intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
      intent.setAction(Intent.ACTION_SEND);
      intent.setType("text/plain");
      intent.setPackage(packageName);
      intent.putExtra("jid", phone + "@s.whatsapp.net");
      intent.putExtra(Intent.EXTRA_SUBJECT, title);
      intent.putExtra(Intent.EXTRA_TEXT, extraText);

      applicationContext.startActivity(intent);
      result.success(true);
    } catch (Exception ex) {
      Log.println(Log.ERROR, "", "FlutterShare: Error");
      result.error(ex.getMessage(), null, null);
    }
  }

  private void shareFile(MethodCall call, Result result) {
    try {
      ArrayList<String> filePaths = call.argument("filePath");
      String title = call.argument("title");
      String text = call.argument("text");
      String chooserTitle = call.argument("chooserTitle");
      String phone = call.argument("phone");
      String packageName = call.argument("package");

      if (filePaths == null || filePaths.isEmpty()) {
        Log.println(Log.ERROR, "", "FlutterShare: ShareLocalFile Error: filePath null or empty");
        result.error("FlutterShare: FilePath cannot be null or empty", null, null);
        return;
      } else if (phone == null || phone.isEmpty()) {
        Log.println(Log.ERROR, "", "FlutterShare Error: phone null or empty");
        result.error("FlutterShare: phone cannot be null or empty", null, null);
        return;
      } else if (packageName == null || packageName.isEmpty()) {
        Log.println(Log.ERROR, "", "FlutterShare Error: Package name null or empty");
        result.error("FlutterShare:Package name cannot be null or empty", null, null);
        return;
      }

      ArrayList<Uri> files = new ArrayList<>();
      for (String filePath : filePaths) {
        File file = new File(filePath);
        Uri fileUri = FileProvider.getUriForFile(
            applicationContext,
            applicationContext.getPackageName() + ".provider",
            file);
        files.add(fileUri);
      }

      Intent intent = new Intent();
      intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
      intent.setAction(Intent.ACTION_SEND_MULTIPLE);
      intent.setType("*/*");
      intent.setPackage(packageName);
      intent.putExtra("jid", phone + "@s.whatsapp.net");
      intent.putParcelableArrayListExtra(Intent.EXTRA_STREAM, files);
      intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);

      applicationContext.startActivity(intent);
      result.success(true);
    } catch (Exception ex) {
      result.error(ex.getMessage(), null, null);
      Log.println(Log.ERROR, "", "FlutterShare: Error");
    }
  }
}