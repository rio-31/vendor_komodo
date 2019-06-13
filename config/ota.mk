ifeq ($(KOMODO_BUILD_TYPE), OFFICIAL)

KOMODO_OTA_VERSION_CODE := ten

KOMODO_PROPERTIES += \
    org.komodo.ota.version_code=$(KOMODO_OTA_VERSION_CODE) \
    sys.ota.disable_uncrypt=1

PRODUCT_PACKAGES += \
    Updates

PRODUCT_COPY_FILES += \
    vendor/komodo/config/permissions/org.komodo.ota.xml:system/etc/permissions/org.komodo.ota.xml

endif
