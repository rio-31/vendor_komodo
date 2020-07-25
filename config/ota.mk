ifeq ($(KOMODO_VARIANT), RELEASE)

KOMODO_OTA_VERSION_CODE := ten

KOMODO_PROPERTIES += \
    org.komodo.ota.version_code=$(KOMODO_OTA_VERSION_CODE) \
    sys.ota.disable_uncrypt=1

PRODUCT_PACKAGES += \
    Updates

endif
