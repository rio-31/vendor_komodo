# Copyright (C) 2020 Komodo-OS-Rom
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ADB
ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# ART do not include debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/komodo/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/komodo/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/komodo/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh \

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_COPY_FILES += \
    vendor/komodo/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/komodo/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/komodo/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Branding
include vendor/komodo/config/branding.mk

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Copy all custom init rc files
$(foreach f,$(wildcard vendor/komodo/prebuilt/common/etc/init/*.rc),\
    $(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/komodo/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Default notification/alarm sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.notification_sound=Popcorn.ogg \
    ro.config.alarm_alert=Bright_morning.ogg

# Dex Preopt Speed apps
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    Settings \
    KomodoQuickStep

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# G-Apps build type
ifeq ($(CURRENT_BUILD_TYPE), gapps)
include vendor/gapps/config.mk
endif

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# OTA
include vendor/komodo/config/ota.mk
# ota allow downgrade
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif

# Packages
include vendor/komodo/config/packages.mk

# permission Priv-App
PRODUCT_COPY_FILES += \
    vendor/komodo/config/permissions/backup.xml:system/etc/sysconfig/backup.xml \
    vendor/komodo/config/permissions/privapp-permissions-fm.xml:system/etc/permissions/privapp-permissions-fm.xml \
    vendor/komodo/config/permissions/org.lineageos.snap.xml:system/etc/permissions/org.lineageos.snap.xml \
    vendor/komodo/config/permissions/privapp-permissions-system-komodo.xml:system/etc/permissions/privapp-permissions-system-komodo.xml \
    vendor/komodo/config/permissions/privapp-permissions-product-komodo.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-product-komodo.xml

# permission Google
PRODUCT_COPY_FILES += \
    vendor/komodo/prebuilt/common/etc/permissions/privapp-permissions-elgoog.xml:system/etc/permissions/privapp-permissions-elgoog.xml

# permission OmniStyles
PRODUCT_COPY_FILES += \
    vendor/komodo/prebuilt/etc/permissions/privapp-permissions-omni.xml:system/etc/permissions/privapp-permissions-omni.xml

# power whitelist
PRODUCT_COPY_FILES += \
    vendor/komodo/config/permissions/custom-power-whitelist.xml:system/etc/sysconfig/custom-power-whitelist.xml

# Properties
PRODUCT_BRAND ?= Komodo OS

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    ro.setupwizard.rotation_locked=true

# properties of google IME
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.ime.height_ratio=1.05 \
    ro.com.google.ime.emoji_key=false

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Themed bootanimation
TARGET_MISC_BLOCK_OFFSET ?= 0
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.misc.block.offset=$(TARGET_MISC_BLOCK_OFFSET)
PRODUCT_PACKAGES += \
    misc_writer_system \
    themed_bootanimation

# Themes & Overlays
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/komodo/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/komodo/overlay/common
# overlays
include vendor/komodo/config/accents.mk
include vendor/komodo/config/primary.mk

# GVisualMod
include vendor/komodo/config/gvm.mk

# Pixel Style
include vendor/pixelstyle/config.mk

-include $(WORKSPACE)/build_env/image-auto-bits.mk
