# Required
PRODUCT_PACKAGES += \
    ThemePicker

# Extra apps
ifeq ($(CURRENT_BUILD_TYPE), nogapps)
PRODUCT_PACKAGES += \
    messaging \
    Gallery2
endif
