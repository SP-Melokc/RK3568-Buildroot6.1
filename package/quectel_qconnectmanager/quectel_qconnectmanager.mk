################################################################################
#
# Connect Manager program
#
################################################################################

QUECTEL_QCONNECTMANAGER_VERSION = 1.0
QUECTEL_QCONNECTMANAGER_SITE_METHOD = local
QUECTEL_QCONNECTMANAGER_SITE = $(TOPDIR)/package/quectel_qconnectmanager/quectel_qconnectmanager
QUECTEL_QCONNECTMANAGER_LICENSE = Apache V2.0
QUECTEL_QCONNECTMANAGER_LICENSE_FILES = NOTICE

define QUECTEL_QCONNECTMANAGER_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) -C $(@D) CC=$(TARGET_CC)
endef

define QUECTEL_QCONNECTMANAGER_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/quectel-CM $(TARGET_DIR)/usr/bin/quectel-CM
    $(INSTALL) -D -m 0755 $(@D)/quectel-qmi-proxy $(TARGET_DIR)/usr/bin/quectel-qmi-proxy
    $(INSTALL) -D -m 0755 $(@D)/quectel-mbim-proxy $(TARGET_DIR)/usr/bin/quectel-mbim-proxy
    $(INSTALL) -D -m 0755 $(@D)/quectel-atc-proxy $(TARGET_DIR)/usr/bin/quectel-atc-proxy
endef

$(eval $(generic-package))
