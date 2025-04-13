//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <whatsapp_file_share/whatsapp_file_share_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) whatsapp_file_share_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "WhatsappFileSharePlugin");
  whatsapp_file_share_plugin_register_with_registrar(whatsapp_file_share_registrar);
}
