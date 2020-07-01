# Define Var
CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
LIST = $(shell cat vendor/komodo/komodo.devices | awk '{ print $$1 }')

# Komodo Version
KOMODO_PLATFORM_VERSION := 2.7
KOMODO_VERSION_PROP := $(KOMODO_PLATFORM_VERSION)

# Set all versions
KOMODO_DATE_YEAR := $(shell date -u +%Y)
KOMODO_DATE_MONTH := $(shell date -u +%m)
KOMODO_DATE_DAY := $(shell date -u +%d)
KOMODO_DATE_HOUR := $(shell date -u +%H)
KOMODO_DATE_MINUTE := $(shell date -u +%M)
KOMODO_BUILD_DATE_UTC := $(shell date -d '$(KOMODO_DATE_YEAR)-$(KOMODO_DATE_MONTH)-$(KOMODO_DATE_DAY) $(KOMODO_DATE_HOUR):$(KOMODO_DATE_MINUTE) UTC' +%s)
KOMODO_BUILD_DATE := $(KOMODO_DATE_YEAR)$(KOMODO_DATE_MONTH)$(KOMODO_DATE_DAY)-$(KOMODO_DATE_HOUR)$(KOMODO_DATE_MINUTE)

# Default, it can be overriden.
KOMODO_BUILD_TYPE ?= ALPHA
CURRENT_BUILD_TYPE ?= nogapps
IS_TEST ?= false

# Komodo Official Release
ifeq ($(KOMODO_RELEASE), true)
    ifeq ($(filter $(CURRENT_DEVICE), $(LIST)), $(CURRENT_DEVICE))
       IS_OFFICIAL=true
       KOMODO_BUILD_TYPE := RELEASE
       else
       KOMODO_BUILD_TYPE := ALPHA
    endif
    ifneq ($(IS_TEST), true)
       KOMODO_BUILD_TYPE := BETA
    endif
endif

# Type of zip 
ifeq ($(CURRENT_BUILD_TYPE), nogapps)
     KOMODO_BUILD_ZIP_TYPE := TOXICOFERA
  else
     KOMODO_BUILD_ZIP_TYPE := GAPPS
endif

KOMODO_VERSION := KomodoOS-$(KOMODO_BUILD)-$(KOMODO_PLATFORM_VERSION)-$(KOMODO_BUILD_DATE)-$(KOMODO_BUILD_TYPE)-$(KOMODO_BUILD_ZIP_TYPE)

TARGET_PRODUCT_SHORT := $(subst aosp_,,$(KOMODO_BUILD))

ROM_FINGERPRINT := KomodoOS/$(KOMODO_PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(KOMODO_BUILD_DATE)

KOMODO_PROPERTIES := \
    org.komodo.version=$(KOMODO_VERSION_PROP) \
    org.komodo.version.display=$(KOMODO_VERSION) \
    org.komodo.build_date=$(KOMODO_BUILD_DATE) \
    org.komodo.build_date_utc=$(KOMODO_BUILD_DATE_UTC) \
    org.komodo.build_type=$(KOMODO_BUILD_TYPE) \
    org.komodo.ziptype=$(KOMODO_BUILD_ZIP_TYPE) \
    org.komodo.fingerprint=$(ROM_FINGERPRINT)

# Variable file name for jenkins
$(info) $(shell echo $(KOMODO_VERSION) > $(OUT_DIR)/var-file_name)
