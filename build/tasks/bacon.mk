# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017 The LineageOS Project
# Copyright (C) 2018 The PixelExperience Project
# Copyright (C) 2019-2020 Komodo OS Project
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

#
# Build system colors
#
# PFX: Prefix "target C++:" in yellow
# INS: Module "Install:" output color (cyan for ics)
ifneq ($(BUILD_WITH_COLORS),0)
    include $(TOP_DIR)vendor/komodo/build/core/colors.mk
endif

KOMODO_TARGET_PACKAGE := $(PRODUCT_OUT)/$(KOMODO_VERSION).zip

.PHONY: komodo
komodo: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) mv $(INTERNAL_OTA_PACKAGE_TARGET) $(KOMODO_TARGET_PACKAGE)
	$(hide) $(MD5SUM) $(KOMODO_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(KOMODO_TARGET_PACKAGE).md5sum
	$(hide) ./vendor/komodo/tools/generate_json_build_info.sh $(KOMODO_TARGET_PACKAGE)
	@echo -e ""
	@echo -e ${CL_RED}"Finish ${cya}Building ${bldcya}Komodo ${txtrst}"${CL_RED}
	@echo -e ""
	@echo -e ${CL_GRN}"	▄▄   ▄▄▄    ▄▄▄▄    ▄▄▄  ▄▄▄    ▄▄▄▄    ▄▄▄▄▄       ▄▄▄▄	"${CL_GRN}
	@echo -e ${CL_GRN}"	██  ██▀    ██▀▀██   ███  ███   ██▀▀██   ██▀▀▀██    ██▀▀██	"${CL_GRN}
	@echo -e ${CL_GRN}"	██▄██     ██    ██  ████████  ██    ██  ██    ██  ██    ██	"${CL_GRN}
	@echo -e ${CL_GRN}"	█████     ██    ██  ██ ██ ██  ██    ██  ██    ██  ██    ██	"${CL_GRN}
	@echo -e ${CL_GRN}"	██  ██▄   ██    ██  ██ ▀▀ ██  ██    ██  ██    ██  ██    ██	"${CL_GRN}
	@echo -e ${CL_GRN}"	██   ██▄   ██▄▄██   ██    ██   ██▄▄██   ██▄▄▄██    ██▄▄██	"${CL_GRN}
	@echo -e ${CL_GRN}"	▀▀    ▀▀    ▀▀▀▀    ▀▀    ▀▀    ▀▀▀▀    ▀▀▀▀▀       ▀▀▀▀	"${CL_GRN}
	@echo -e ""
	@echo -e ${CL_RED}"================================================"${CL_RED}
	@echo -e ${CL_RED}"Komodo Dragon Islands"${CL_RED}
	@echo -e ${CLR_YLW}"zip: "$(KOMODO_TARGET_PACKAGE)${CLR_YLW}
	@echo -e ${CLR_YLW}"md5: `cat $(KOMODO_TARGET_PACKAGE).md5sum | cut -d ' ' -f 1`"${CLR_YLW}
	@echo -e ${CLR_YLW}"size:`ls -lah $(KOMODO_TARGET_PACKAGE) | cut -d ' ' -f 5`"${CLR_YLW}
	@echo -e ${CL_RED}"================================================"${CL_RED}
	@echo -e ""
