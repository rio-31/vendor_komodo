# Required
PRODUCT_PACKAGES += \
    ThemePicker \
    komodoOverlayStub

# Extra apps
ifeq ($(CURRENT_BUILD_TYPE), nogapps)
PRODUCT_PACKAGES += \
    messaging \
    Gallery2
endif
