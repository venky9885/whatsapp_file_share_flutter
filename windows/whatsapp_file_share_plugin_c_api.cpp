#include "include/whatsapp_file_share/whatsapp_file_share_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "whatsapp_file_share_plugin.h"

void WhatsappFileSharePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  whatsapp_file_share::WhatsappFileSharePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
