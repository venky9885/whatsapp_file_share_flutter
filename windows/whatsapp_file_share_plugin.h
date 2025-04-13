#ifndef FLUTTER_PLUGIN_WHATSAPP_FILE_SHARE_PLUGIN_H_
#define FLUTTER_PLUGIN_WHATSAPP_FILE_SHARE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace whatsapp_file_share {

class WhatsappFileSharePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  WhatsappFileSharePlugin();

  virtual ~WhatsappFileSharePlugin();

  // Disallow copy and assign.
  WhatsappFileSharePlugin(const WhatsappFileSharePlugin&) = delete;
  WhatsappFileSharePlugin& operator=(const WhatsappFileSharePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace whatsapp_file_share

#endif  // FLUTTER_PLUGIN_WHATSAPP_FILE_SHARE_PLUGIN_H_
