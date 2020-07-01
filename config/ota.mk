ifeq ($(KOMODO_BUILD_TYPE), OFFICIAL)

KOMODO_OTA_VERSION_CODE := ten

KOMODO_PROPERTIES += \
    org.komodo.ota.version_code=$(KOMODO_OTA_VERSION_CODE) \
    sys.ota.disable_uncrypt=1

PRODUCT_PACKAGES += \
    Updates

else
TARGET_SKIP_OTA_PACKAGE := true

endif
