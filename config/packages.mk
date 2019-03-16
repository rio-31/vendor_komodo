# Required
PRODUCT_PACKAGES += \
    ThemePicker \
    komodoOverlayStub \
    OmniStyle \
    Longshot \
    NoCutoutOverlay

# Extra apps
ifeq ($(CURRENT_BUILD_TYPE), nogapps)
PRODUCT_PACKAGES += \
    messaging \
    Gallery2 \
    Dialer \
    FirefoxLite
endif
